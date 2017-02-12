class TweetsController < ApplicationController
  before_action :set_tweet, only: [:edit, :update, :destroy]
  
  def index
    @tweets = Tweet.all
  end

  def new
    if params[:back]
      @tweets = Tweet.new(tweets_params)
    else
      @tweets = Tweet.new
    end
  end

  def create
    @tweets = Tweet.new(tweets_params)
    if @tweets.save
      redirect_to tweets_path, notice: "投稿を作成しました！"
    else
      render 'new'
    end
  end

  def edit
    @tweets = Tweet.find(params[:id])
  end

  def update
    @tweets = Tweet.find(params[:id])
    @tweets.update(tweets_params)
    if @tweets.save
      redirect_to tweets_path, notice: "投稿を更新しました！"
    else
      render 'edit'
    end
  end

  def destroy
    @tweets = Tweet.find(params[:id])
    @tweets.destroy
    redirect_to tweets_path, notice: "投稿を削除しました！"
  end

  def confirm
    @tweets = Tweet.new(tweets_params)
    render :new if @tweets.invalid?
  end
  
  private
    def tweets_params
      params.require(:tweet).permit(:content)
    end
  
    def set_tweet
      @tweets = Tweet.find(params[:id])
    end
  
end
