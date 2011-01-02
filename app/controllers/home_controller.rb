
class HomeController < ApplicationController
  def index
    @photos = (flickr.photos.search(:user_id => "49191687@N05", :tags => "nomad", :per_page => 10, :extras => "date_taken, owner_name, geo, tags" ).to_a +
               flickr.photos.search(:user_id => "23276058@N04", :tags => "nomad", :per_page => 10, :extras => "date_taken, owner_name, geo, tags" ).to_a).sort! {|a,b| a.datetaken <=> b.datetaken }
  end

  def show
    @users = params[:users].split(",").map { |it| it.strip() }

    @no_such_users = []
    @nsids = []
    @users.each do |u|
      begin
        temp_id = flickr.people.findByUsername(:username => u).nsid
      rescue FlickRaw::FailedResponse
        @no_such_users << u
      else
        @nsids << temp_id
      end
    end
    
    @photos = []
    @nsids.each do |u|
      @photos += flickr.photos.search(:user_id => u, :tags => params[:tags], :per_page => 3, :extras => "date_taken, owner_name, geo, tags" ).to_a
    end
    @photos.sort! {|a, b| a.datetaken <=> b.datetaken }
  end

end
