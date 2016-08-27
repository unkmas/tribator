require 'sinatra'
require 'json'

class Tribator < Sinatra::Base
  get '/' do
    haml :index
  end

  get '/work' do
    haml :work
  end

  get '/tasks/get' do
    @task = Task.choose

    task.nil? ? {}.to_json : @task.values.to_json
  end

  post '/tasks/:task_id/answer' do
    @task = Task[params[:task_id]]
    halt 404 if @task.nil?

    @answer = Answer.create(answer: params[:answer])
    @task.add_answer(@answer)

    [201, {}, {}]
  end
end