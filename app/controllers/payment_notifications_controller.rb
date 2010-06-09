class PaymentNotificationsController < ApplicationController

  #protect_from_forgery :except => :create
  skip_before_filter :verify_authenticity_token


  # POST /payment_notifications
  # POST /payment_notifications.xml
  def create
    PaymentNotification.create!(:params => params, :inscription_id => params[:invoice], :status => params[:payment_status], :transaction_id => params[:txn_id])
    render :nothing => true
  end

end
