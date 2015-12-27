class MessagesController < ApplicationController
  load_and_authorize_resource
  before_action :set_message, only: [:show, :destroy]

  def received
    @messages = current_user.received_messages
    render :index
  end

  def sent
    @messages = current_user.sent_messages
    render :index
  end

  def new
    @message = Message.new
  end

  def show
    session[:prev_url] = request.referer
    unless @message.read_time
      @message.update_attribute(:read_time, Time.now)
    end
  end

  def create
    @message = Message.new(message_params)
    @message_received = Message.new(message_params)

    recipient = @message.to

    @message.user = current_user
    @message.from = current_user
    @message.send_time = Time.now
    @message.read_time = Time.now
    @message.subject = '---No subject---' if @message.subject.blank?

    @message_received.user = recipient
    @message_received.from = current_user
    @message_received.send_time = Time.now
    @message_received.subject = '---No subject---' if @message_received.subject.blank?

    respond_to do |format|
      if @message.save && @message_received.save && current_user.add_role(:owner, @message) && recipient.add_role(:owner, @message_received)
        format.html { redirect_to :received_messages, notice: 'Message was sent.' }
      else
        format.html { render :new }
      end
    end
  end

  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to session[:prev_url] ? session[:prev_url] : :back, notice: 'Message was deleted.' }
    end
  end

  private

  def set_message
    @message = Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:text, :to_name, :subject)
  end
end
