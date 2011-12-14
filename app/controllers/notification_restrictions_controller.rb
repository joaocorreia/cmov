class NotificationRestrictionsController < ApplicationController

  # GET /notification_restrictions/user/id
  # GET /notification_restrictions/user/id.json
  def get_by_user
    @notification_restriction = NotificationRestriction.where("user_id = ?",params[:id])
	if @notification_restriction.empty?
		@n = NotificationRestriction.new(:user_id=>params[:id])
		@n.save
		@notification_restriction = @n
	else
		@notification_restriction = @notification_restriction.first
	end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @notification_restriction }
    end
  end
  
  # GET /notification_restrictions
  # GET /notification_restrictions.json
  def index
    @notification_restrictions = NotificationRestriction.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @notification_restrictions }
    end
  end

  # GET /notification_restrictions/1
  # GET /notification_restrictions/1.json
  def show
    @notification_restriction = NotificationRestriction.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @notification_restriction }
    end
  end

  # GET /notification_restrictions/new
  # GET /notification_restrictions/new.json
  def new
    @notification_restriction = NotificationRestriction.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @notification_restriction }
    end
  end

  # GET /notification_restrictions/1/edit
  def edit
    @notification_restriction = NotificationRestriction.find(params[:id])
  end

  # POST /notification_restrictions
  # POST /notification_restrictions.json
  def create
    @notification_restriction = NotificationRestriction.new(params[:notification_restriction])

    respond_to do |format|
      if @notification_restriction.save
        format.html { redirect_to @notification_restriction, notice: 'Notification restriction was successfully created.' }
        format.json { render json: @notification_restriction, status: :created, location: @notification_restriction }
      else
        format.html { render action: "new" }
        format.json { render json: @notification_restriction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /notification_restrictions/1
  # PUT /notification_restrictions/1.json
  def update
    @notification_restriction = NotificationRestriction.find(params[:id])

    respond_to do |format|
      if @notification_restriction.update_attributes(params[:notification_restriction])
        format.html { redirect_to @notification_restriction, notice: 'Notification restriction was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @notification_restriction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notification_restrictions/1
  # DELETE /notification_restrictions/1.json
  def destroy
    @notification_restriction = NotificationRestriction.find(params[:id])
    @notification_restriction.destroy

    respond_to do |format|
      format.html { redirect_to notification_restrictions_url }
      format.json { head :ok }
    end
  end
end
