class LinksController < ApplicationController
  before_action :set_link, only: %i[ edit update destroy ]

  def index
    @links = Current.user.links.order(created_at: :desc)
  end

  def new
    @link = Current.user.links.new
  end

  def edit
  end

  def create
    @link = Current.user.links.new(link_params)

    if @link.save
      redirect_to links_path, notice: "Link was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @link.update(link_params)
      redirect_to links_path, notice: "Link was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @link.destroy!
    redirect_to links_path, notice: "Link was successfully destroyed.", status: :see_other
  end

  private
    def set_link
      @link = Current.user.links.find(params.expect(:id))
    end

    def link_params
      params.expect(link: [ :url, :title, :description ])
    end
end
