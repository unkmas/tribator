require 'sinatra'
require 'json'

class Tribator < Sinatra::Base
  get '/' do
    haml :index
  end

  get '/work' do
    haml :work
  end

  get '/finish' do
    @answers_count = Answer.where(ip: request.ip).count

    haml :finish
  end

  get '/tasks/get' do
    @task = Task.choose

    @task.nil? ? {}.to_json : @task.values.to_json
  end

  post '/tasks/:task_id/answer' do
    @task = Task[params[:task_id]]
    halt 404 if @task.nil?

    @answer = Answer.create(answer: params[:answer], ip: request.ip, task_id: @task.id)

    [201, {}, {}]
  end
end