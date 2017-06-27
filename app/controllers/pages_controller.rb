class PagesController < ApplicationController
  before_action :check_service, only: [:services]
  skip_before_action :verify_authenticity_token, only: [:contact_us]

  def index; end

  def about; end

  def contact; end

  def contact_us

    render json: { message: 'Item number #{params[:id]} does not exist'}
  end


  def services
    service = service_content
    @house_reno_active = active?('renovation')
    @carpentry_active = active?('carpentry')
    @masonry_active = active?('masonry')
    @title = service[:title]
    @subtitle = service[:subtitle]
    @description = service[:description]
    @background_picture = service[:background_picture]
    @picture1 = service[:picture1]
    @picture2 = service[:picture2]
    @picture3 = service[:picture3]
  end

  private

  SUPPORTED_SERVICES = %w[renovation carpentry masonry].freeze

  RENOVATION_SERVICE = { title: 'Renovation Service',
                         subtitle: 'House Renovation',
                         description: 'We do house renovations',
                         background_picture: '/assets/bath1.jpg',
                         picture1: '/assets/reno1.jpg',
                         picture2: '/assets/reno2.jpg',
                         picture3: '/assets/familytokitchen.jpg' }.freeze
  CARPENTRY_SERVICE = { title: 'Carpentry Service',
                        subtitle: 'Decks & Carpentry',
                        description: 'We do decks and variations of carpentry',
                        background_picture: '/assets/15.jpg',
                        picture1: '/assets/5.jpg',
                        picture2: '/assets/goodeck.jpg',
                        picture3: '/assets/familyroom3.jpg' }.freeze
  MASONRY_SERVICE = { title: 'Concrete Service',
                      subtitle: 'Masonry Concrete ',
                      description: 'We do various concrete services',
                      background_picture: '/assets/basement1.jpg',
                      picture1: '/assets/1.jpg',
                      picture2: '/assets/3.jpg',
                      picture3: '/assets/basement3.jpg' }.freeze

  def check_service
    raise ActionController::RoutingError.new('Not Found') unless SUPPORTED_SERVICES.include?(service)
  end

  def service
    params[:service]
  end

  def active?(service_in_question)
    if service_in_question == service
      'active'
    else
      ''
    end
  end

  def service_content
    if service == 'renovation'
      RENOVATION_SERVICE
    elsif service == 'carpentry'
      CARPENTRY_SERVICE
    elsif service == 'masonry'
      MASONRY_SERVICE
    end
  end
end
