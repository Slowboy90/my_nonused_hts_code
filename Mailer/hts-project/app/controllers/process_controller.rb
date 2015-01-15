# Class for processing input and output for SailsJS client application
class ProcessController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :person_key_check, only: [:check_person, :create_person]
  before_action :image_key_check, only: [:create, :read_pictures]

  def check_person # Check if person exists in database
    render json: Person.where(first_name: "#{params[:first_name]}")
      .where(last_name: "#{params[:last_name]}")
      .select(:id, :zipcode, :first_name, :last_name)
    # Validation of results happens on SailsJS side
  end

  def create_person # Create person when submitted from NodeJS
    person = Person.new(person_params)
    if person.save  # Save the person into the database
      params[:person_id] = person.id # pass the person ID to create
      create # Upload the sent picture
    else
      render text: person.errors.full_messages # Show error messages
    end
  end

  def read_pictures # Get all processed pictures
    @photos = []
    photos = ProcessedImage.all
    photos.each do |p|
      @photos.push(p.file_name.url)
    end
    render json: @photos
  end

  def create # Create image when submitted from NodeJS
    @photo = ProcessedImage.new(image_params)
    randomGeneratedCode = SecureRandom.urlsafe_base64(nil, false)
    if @photo.save
      p = Person.where(id: @photo.person_id).first 
      p.unique_code = randomGeneratedCode
      p.save
      UniqueCodeMailer.code_email(p).deliver
      render json: { 'success' => 'Upload gelukt' }
    else
      render json: { 'error' => 'Upload mislukt, vraag de beheerder om hulp' }
    end
  end

  ##################################
  #   BEGIN PRIVATE LOGIC BLOCK    #
  ##################################

  private

  def person_params # Strong parameters for person creation
    params.permit(:first_name,
                  :last_name,
                  :email,
                  :street,
                  :number,
                  :city,
                  :zipcode,
                  :graduation_year,
                  :major)
  end

  def image_params # Strong parameters for image upload
    params.permit(:file_name,
                  :person_id)
  end

  def person_key_check # Secure key for Person actions
    t = '1b36fc3a3461ecf662b8b839ab7c96ad643e77c886f31346a259bb4bc69b6ab87266efa6af227c2492d999b60c24a33ee98f8af1a5fdec8bfd19c274b7166976'
    die unless params[:post_token] == t
  end

  def image_key_check # Secure key for image actions
    t = '48d2fc2358a74103eddcfc91ce56b845704aa557d6cfd12d83a064ba315118e982f4ca049b1ad309176d5593475b06ac6c1736bfa609349c981cb29687ad44e0'
    die unless params[:post_token] == t
  end

  def die # Function for unauthorized access to functions
    render text: 'Unauthorized'
  end
end
