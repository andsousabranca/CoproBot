class ChatsController < ApplicationController

  def create
    @section = Section.find(params[:section_id])
    @chat = Chat.new(title: @section.name, section_id: @section.id, user_id: 1)

    if @chat.save
      redirect_to chat_path(@chat)
    end
  end


    def show
    @chat = Chat.find(params[:id])
    @section = @chat.section
    @user = @chat.user
    @message = Message.new()

    # get all the current and historic chats of the section
    @chats = @section.chats.order(created_at: :desc)
  end

  def chat_params
    params.require(:chat).permit(:title)
  end

end
