import {Socket} from "phoenix";
import $ from "jquery";

class SocketHandler {
    static init() {
        let socket = new Socket("/socket", {});
        socket.connect();

        var $status = $("#status");
        var $messages = $("#messages");
        var $input = $("#message-input");
        // Now that you are connected, you can join channels with a topic:
        let channel = socket.channel("rooms:lobby", {});
        channel.join()
            .receive("ok", resp => {
                console.log("Joined successfully", resp)
            })
            .receive("error", resp => {
                console.log("Unable to join", resp)
            });
        channel.onError(e => console.log('something went wrong', e));
        channel.onClose(e => console.log('Channel closed', e));

        //send new message if user presses enter
        $input.off('keypress').on('keypress', e => {
            if (e.keyCode == 13) {
                channel.push('shout', {content: $input.val()});
                $input.val('');
            }
        });

        //render new messages on clients
        channel.on('shout', message => {
            $messages.append(this.messageTemplate(message))
        })
    }

    static sanitize(html) {
        return $("<div/>").text(html).html()
    }

    static messageTemplate(msg) {
        let content = this.sanitize(msg.content);
        return (`<p>${content}</p>`)
    }
}

$(() => SocketHandler.init());
export default SocketHandler
