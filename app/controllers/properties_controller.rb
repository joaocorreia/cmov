require "net/http"
require "net/https"
require "speedy_c2dm"
require "c2dm"
class PropertiesController < ApplicationController

  # GET /get_interested
  # GET /get_interested.json
  def get_interested
  
    @properties = Interest.joins(:property).where("user_id = ?",params[:user_id]).select("properties.*");
    render json: @properties 
	
  end
  
  # GET /properties
  # GET /properties.json
  def index
    @properties = Property.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @properties }
    end
  end

  # GET /properties/1
  # GET /properties/1.json
  def show
    @property = Property.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @property }
    end
  end

  # GET /properties/new
  # GET /properties/new.json
  def new
    @property = Property.new

	
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @property }
    end
  end

  # GET /properties/1/edit
  def edit
    @property = Property.find(params[:id])
  end

  # POST /properties
  # POST /properties.json
  def create
    @property = Property.new(params[:property])

    respond_to do |format|
      if @property.save
	  
	  #notify users
	  
		@users = User.all
	  
	  @users.each do |u|

	  #c2dm = C2DM.new("org.feup.cmov.app@gmail.com", "feupcmov01", "PropsFinder")
	  #notification = { :registration_id => u.registration_id, :data => { :message => "Ola" }, :collapse_key => "biteme" }
	  #c2dm.send_notification(notification)

		options = {
		  :registration_id => u.registration_id,
		  :message => @property.id,
		  :extra_data => nil,
		  :collapse_key => "some-collapse-key"
		}
		
		@restrictionPassed = true
		#check if it matches the users price restrictions
		@restriction = NotificationRestriction.where("user_id = ?",u.id)
		
		if not @restriction.empty?
		@restriction = @restriction.first
			if @property.price >= @restriction.minimumPrice && @property.price <= @restriction.maximumPrice 
				@restrictionPassed = true
			else
				@restrictionPassed = false
			end
		end
		
		if @restrictionPassed == true
			@interest = Interest.new(:user_id => u.id, :property_id => @property.id)
			@interest.save
			
			puts @property.id
			#puts u.username
			
			response = SpeedyC2DM::API.send_notification(options)
		end
		puts response
	  end
	  
	  
        format.html { redirect_to @property, notice: 'Property was successfully created.' }
        format.json { render json: @property, status: :created, location: @property }
      else
        format.html { render action: "new" }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /properties/1
  # PUT /properties/1.json
  def update
    @property = Property.find(params[:id])

    respond_to do |format|
      if @property.update_attributes(params[:property])
        format.html { redirect_to @property, notice: 'Property was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /properties/1
  # DELETE /properties/1.json
  def destroy
    @property = Property.find(params[:id])
    @property.destroy

    respond_to do |format|
      format.html { redirect_to properties_url }
      format.json { head :ok }
    end
  end
end
