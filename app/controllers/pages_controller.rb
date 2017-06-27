class PagesController < ApplicationController
  before_action :check_service, only: [:services]

  def index
  end

  def services
    service = service_content
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
  CARPENTRY_SERVICE = { title: 'Renovation Service',
                        subtitle: 'House Renovation',
                        description: 'We do house renovations',
                        background_picture: '/assets/bath1.jpg',
                        picture1: '/assets/reno1.jpg',
                        picture2: '/assets/reno2.jpg',
                        picture3: '/assets/familytokitchen.jpg' }.freeze
  MASONRY_SERVICE = { title: 'Renovation Service',
                      subtitle: 'House Renovation',
                      description: 'We do house renovations',
                      background_picture: '/assets/bath1.jpg',
                      picture1: '/assets/reno1.jpg',
                      picture2: '/assets/reno2.jpg',
                      picture3: '/assets/familytokitchen.jpg' }.freeze

  def check_service
    raise ActionController::RoutingError.new('Not Found') unless SUPPORTED_SERVICES.include?(service)
  end

  def service
    params[:service]
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
