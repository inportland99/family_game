class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize_user, only: :edit

  # allow acces to these functions in the view using helper_method
  helper_method :sort_column, :sort_direction

  # GET /users
  # GET /users.json
  def index
    @users = User.order(sort_column + " " + sort_direction)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @students = Student.where("user_id = ?", @user.id)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    # unless current_user.role == "Admin" || current_user.id == @user.id
    #   flash[:error] = 'You can not edit selected user.'
    #   redirect_to users_path
    # end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private

  def authorize_user
    @user = User.find(params[:id])
    unless current_user.admin? || current_user.id == @user.id
      flash[:error] = 'You can not edit selected user.'
      redirect_to users_path
    end
  end

  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
