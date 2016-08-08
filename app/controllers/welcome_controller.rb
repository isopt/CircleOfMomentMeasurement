class WelcomeController < ApplicationController
  def index
    @users = User.joins(:event_isopts).where("users.is_initialized = ? AND event_isopts.is_published = ?", true, true)
    @event_isopts = EventIsopt.where(is_resettable: false, is_published: true)
  end
end
