# frozen_string_literal: true

# Top-level Application Controller
class ApplicationController < ActionController::API
  include JsonWebToken

  before_action :authenticate_request
  before_action :set_request_id_in_thread_local

  def set_request_id_in_thread_local
    Thread.current.thread_variable_set(
      'request_id', request.request_id
    )
  end

  def append_info_to_payload(payload)
    super
    payload[:request_id] = request.request_id
  end

  private

  def authenticate_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    decoded = jwt_decode(header)
    @current_user = User.find(decoded[:user_id])
  end
end
