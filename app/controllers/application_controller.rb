require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/posts/new' do
    erb :new
  end

  post '/posts' do
    @post = Post.create(params)
    redirect to('/posts')
  end

  get '/posts' do
    @posts = Post.all
    erb :index
  end

  get '/posts/:id/edit' do
    @post = Post.find_by_id(params[:id])
    erb :edit
  end

  get '/posts/:id' do
    @post = Post.find_by_id(params[:id])
    erb :show
  end

  patch '/posts/:id' do #edit action
    @post = Post.find_by_id(params[:id])
    @post.name = params[:name]
    @post.content = params[:content]
    @post.save
    redirect to "/posts/#{params[:id]}"
  end

  delete '/posts/:id/delete' do
    @post = Post.find_by_id(params[:id])
    @posts = Post.all
    @post_name = @post.name
    @post.delete
    erb :delete
  end

end
