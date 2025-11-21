class ChatsController < ApplicationController

  def create
    @section = Section.find(params[:section_id])

    # checks if sections has any chats, if yes, initialize @chat with the last one.
    if @section.chats.any?
      @chat = @section.chats.last

      # check if any messages in the chat, if yes, creates a new chat.
      if @chat.messages.any?
        @chat = Chat.new(title: Chat::DEFAULT_TITLE, section_id: @section.id, user_id: current_user.id)
        @chat.save
      end
      redirect_to chat_path(@chat)

    # checks if sections doesn't have chats, initialize @chat with a new one.
    else
      @chat = Chat.new(title: Chat::DEFAULT_TITLE, section_id: @section.id, user_id: current_user.id)
      if @chat.save
        redirect_to chat_path(@chat)
      end

      # TODO: @Pierre, we should usually also add what happens if the chat isnt saved, which can also happen; also for above
    end
  end

  def show
    @chat = Chat.find(params[:id])
    @section = @chat.section
    @message = Message.new

    # get all the current and historic chats of the section
    @chats = @section.chats.where(user: current_user).order(created_at: :desc)
  end

  private

  def chat_params
    params.require(:chat).permit(:title)
  end

end
