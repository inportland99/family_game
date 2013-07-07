class PointsController < ApplicationController
  # GET /points
  # GET /points.json
  def index
    @points = Point.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @points }
    end
  end

  # GET /points/1
  # GET /points/1.json
  def show
    @point = Point.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @point }
    end
  end

  # GET /points/new
  # GET /points/new.json
  def new
    @point = Point.new
    @user = User.find(params[:user_id]) if params[:user_id]
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @point }
    end
  end

  # GET /points/1/edit
  def edit
    @point = Point.find(params[:id])
  end

  # POST /points
  # POST /points.json
  def create
      @point = Point.new(params[:point])
      
      # Set point.xp_earned based on the activity chosen
      @activity = Activity.find(params[:point][:activity_id])
      @point.xp_earned = @activity.activity_xp

      respond_to do |format|
        if @point.save
          flash[:success] = 'Points added successfully'
          format.html { redirect_to user_path(params[:point][:user_id]) }
          format.json { render json: @point, status: :created, location: @point }
        else
          format.html { render action: "new" }
          format.json { render json: @point.errors, status: :unprocessable_entity }
        end
      end
  end

  def multiple
    @activity_ids = params[:point][:activity_id]
    #params[:point].delete(:activity_id)
    @activity_ids.each do |activity_id|
      if !activity_id.blank?
        params[:point][:activity_id] = activity_id

        @point = Point.new(params[:point])

        # Set point.xp_earned based on the activity chosen
        @activity = Activity.find(activity_id)

        @point.xp_earned = @activity.activity_xp
        if !@point.save
          flash[:error] = 'Failed to add points.'
        else
          flash[:success] = 'Added points.'
        end   
      end
    end
    respond_to do |format|
      format.html { redirect_to user_path(params[:point][:user_id]) }
      format.json { render json: @point, status: :created, location: @point }
    end
  end

  # PUT /points/1
  # PUT /points/1.json
  def update
    @point = Point.find(params[:id])

    respond_to do |format|
      if @point.update_attributes(params[:point])
        format.html { redirect_to @point, notice: 'Point was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @point.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /points/1
  # DELETE /points/1.json
  def destroy
    @point = Point.find(params[:id])
    @point.destroy

    respond_to do |format|
      format.html { redirect_to points_url }
      format.json { head :no_content }
    end
  end
end
