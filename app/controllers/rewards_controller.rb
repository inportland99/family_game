class RewardsController < ApplicationController
  before_filter :authenticate_user_or_student, only: :index
  before_filter :authenticate_user!, except: :index

  # GET /rewards
  # GET /rewards.json
  def index
    @rewards = Reward.where("active = ?", true)
    @archived = Reward.where("active = ?", false)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rewards }
    end
  end

  # GET /rewards/1
  # GET /rewards/1.json
  def show
    @reward = Reward.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reward }
    end
  end

  # GET /rewards/new
  # GET /rewards/new.json
  def new
    @reward = Reward.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reward }
    end
  end

  # GET /rewards/1/edit
  def edit
    @reward = Reward.find(params[:id])
  end

  # POST /rewards
  # POST /rewards.json
  def create
    @reward = Reward.new(params[:reward])

    respond_to do |format|
      if @reward.save
        flash[:success] =  'Reward was successfully created.'
        format.html { redirect_to rewards_path }
        format.json { render json: @reward, status: :created, location: @reward }
      else
        format.html { render action: "new" }
        format.json { render json: @reward.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /rewards/1
  # PUT /rewards/1.json
  def update
    @reward = Reward.find(params[:id])
    respond_to do |format|
      if @reward.update_attributes(params[:reward])
        flash[:success] = 'Reward was successfully created.'
        format.html { redirect_to rewards_path }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @reward.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rewards/1
  # DELETE /rewards/1.json
  def destroy
    @reward = Reward.find(params[:id])
    @reward.destroy

    respond_to do |format|
      format.html { redirect_to rewards_url }
      format.json { head :no_content }
    end
  end

  private

  def authenticate_user_or_student
    if current_student
      authenticate_student!
    else
      authenticate_user!
    end
  end

end
