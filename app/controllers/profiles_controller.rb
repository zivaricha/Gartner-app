class ProfilesController < ApplicationController

  def index
    # If one or more of the search fields where entered, search by those fields
    if params[:name] || params[:title] || params[:position] ||
       params[:summary] || params[:skills]

        @profiles = Profile.by_name(params[:name])
        .by_title(params[:title])
        .by_position(params[:position])
        .by_summary(params[:summary])
        .by_skills(params[:skills]).order("id DESC")

    else
      # If not, display all of the saved projects
      @profiles = Profile.all.order("id DESC")
    end

  end

  def new
    @profile = Profile.new
  end

  def create
    # Create a new Profile model instance
    @profile = Profile.new profile_params


    begin
      # Create a profile scraper instance based on the given url
      profile_scraper = Linkedin::Profile.new(params[:profile][:profile_url])
    rescue Exception=>e
      render 'new', notice: "Sorry, i was unable to scrape this profile"

    else
      # Init the profile model instance with the scraped data
      @profile.name = profile_scraper.name
      @profile.title = profile_scraper.title
      @profile.position = profile_scraper.experience.first
      @profile.profile_url = params[:profile][:profile_url]
      @profile.summery = profile_scraper.summary
      @profile.skills = profile_scraper.skills
      @profile.education = profile_scraper.education
      @profile.experience = profile_scraper.experience
      @profile.score = profile_scraper.skills.size * Integer(profile_scraper.number_of_connections)
      

      # Try and save the profile to the database
      if @profile.save
        redirect_to @profile, notice: "profile succefully saved"
      else
        render 'new', notice: "Sorry i was unable to save your profile"
      end
    end

  end

  def show
    @profile = Profile.find(params[:id])
  end

  private

  def profile_params
    params.require(:profile).permit(:profile_url)
  end

end
