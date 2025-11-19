class ChatsController < ApplicationController

    def show
    @chat = Chat.find(params[:id])
    @section = @chat.section
    @user = @chat.user
    @message = Message.new()

    # get all the current and historic chats of the section
    @chats = @section.chats.order(created_at: :desc)
  end
  
end
