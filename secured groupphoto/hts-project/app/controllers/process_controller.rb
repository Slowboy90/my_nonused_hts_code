class ProcessController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action do
    @person_token = '1b36fc3a3461ecf662b8b839ab7c96ad643e77c886f31346a259bb4bc69b6ab87266efa6af227c2492d999b60c24a33ee98f8af1a5fdec8bfd19c274b7166976'
    @image_token = '48d2fc2358a74103eddcfc91ce56b845704aa557d6cfd12d83a064ba315118e982f4ca049b1ad309176d5593475b06ac6c1736bfa609349c981cb29687ad44e0'
  end

  def check_person # Check if person exists in database
    if params[:post_token] == @person_token
      render :json => Person.where(first_name: "#{params[:first_name]}").where(last_name: "#{params[:last_name]}").select(:postcode, :first_name, :last_name)
    else
      die
    end
  end

  def create_person # Create person when submitted from NodeJS
    if params[:post_token] == @person_token
      person = Person.new(person_params)
      if person.save
        render :text => 'saved'
      else
        render :text => person.errors.messages
      end
    else
      die
    end
  end

  def get_pictures # Get all processed pictures
    if params[:post_token] == @image_token
      @photos = []
      photos = ProcessedImage.all
      photos.each do |p|
        @photos.push(p.file_name.url)
      end
      render :json => @photos
    else
      die
    end
  end

  def create # Create image when submitted from NodeJS
    if params[:post_token] == @image_token
      @photo = ProcessedImage.new
      @photo.file_name = params[:file_name]
      @find_person = Person.where(first_name: "#{params[:first_name]}").where(last_name: "#{params[:last_name]}").where(postcode: "#{params[:postcode]}")
      if @find_person.first != nil
        @photo.person_id = @find_person.first.id
      end
      if @photo.save
          render :json => {'success' => 'Upload gelukt'}
      else
          render :json => {'error' => 'Upload mislukt, vraag de beheerder om hulp'}
      end
    else
      die
    end
  end

  private

  def person_params
    params.permit(:first_name, :last_name, :email,:graduation_year, :postcode, :major, :address, :city)
  end

  def die # Function for unauthorized access to functions
    render :text => 'Unauthorized'
  end
end
