
class HomeController < ApplicationController

  def help
    Helper.instance
  end

  class Helper
    include Singleton
    include ActionView::Helpers::TextHelper
  end

  def index
  end

  def show
    @users = params[:users].split(",").map { |it| it.strip() }

    @no_such_users = []
    @nsids = []
    @users.each do |u|
      begin
        temp_id = flickr.people.findByUsername(:username => u).nsid
        @nsids << temp_id
      rescue FlickRaw::FailedResponse
        @no_such_users << u
      end
    end
    @users -= @no_such_users 
    unless @no_such_users.empty?
      flash.now[:error] = "#{help.pluralize(@no_such_users.length, "name")} not found: " + @no_such_users.join(", ")
      @userstring = @users.join(", ")
      @tagstring = params[:tags]
      render :action => :index
    end
    
    @photos = []
    @nsids.each do |u|
      @photos += flickr.photos.search(:user_id => u, :tags => params[:tags], :per_page => params[:num], :extras => "date_taken, owner_name, geo, tags" ).to_a
    end
    @photos.sort! {|a, b| a.datetaken <=> b.datetaken }
  end

end
