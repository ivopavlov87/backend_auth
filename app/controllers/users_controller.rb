class UsersController < ApplicationController
	skip_before_action :authenticate_request, only: [:create]
	before_action :set_user, only: [:show, :destroy]

	# GET /users
	def index
		@users = User.all
		render json: @users, status: :ok
	end

	# GET /users/:id
	def show
		render json: @user, status: :ok
	end

	# POST /users
	def create
		result = UserCreator.new.create_user(
			User.new(user_params)
		)

		if result.created?
			render json: result.user, status: :created
		else
			render json: { errors: result.user.errors.full_messages },
						 status: :unprocessable_entity
		end
	end

  # PUT /users/:id
  def update
    unless @user.update(user_params)
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # DELETE /users/:id
  def destroy
    @user.destroy
  end

  private

  def user_params
    params.require(:user).permit(:username, :name, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
