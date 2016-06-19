class ProfilesController < ApplicationController
  def index
    if params[:name] || params[:skills]
      @profiles = Profile.by_name(params[:name]).by_skills(params[:skills]).order("id DESC")

    else
      @profiles = Profile.all.order("id DESC")#Profile.search(params[:search])
    end

  end

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new profile_params
    profile_scraper = Linkedin::Profile.new(params[:profile][:profile_url])

    @profile.name = profile_scraper.name
    @profile.title = profile_scraper.title
    @profile.position = profile_scraper.location
    @profile.profile_url = params[:profile][:profile_url]
    @profile.summery = profile_scraper.summary
    @profile.skills = profile_scraper.skills
    @profile.education = profile_scraper.education
    @profile.experience = profile_scraper.experience

    #binding.pry #break points the code and than can trace different parameters through server!

    if @profile.save
 #     binding.pry #break points the code and than can trace different parameters through server!
      redirect_to @profile, notice: "profile succefully saved"
    else
      render 'new', notice: "Oh no, i was unable to save your profile"
    end
  end

  def show
    @profile = Profile.find(params[:id])
  end

  private

  def profile_params
    params.require(:profile).permit(:name, :title, :position, :profile_url)
  end

  #, :summery, :skills, :experience, :education
end
