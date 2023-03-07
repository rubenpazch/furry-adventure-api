# frozen_string_literal: true

module Paginable
  protected

  def current_page
    (params[:page] || 1).to_i
  end

  def per_page
    (params[:per_page] || 20).to_i
  end

  def get_links_serializer_options(links_paths, collection, items_per_page)
    to_page_i = items_per_page.to_i * collection.current_page
    total_pages = collection.total_pages
    prev_page = collection.prev_page
    prev_page_url = send(links_paths, page: prev_page)
    next_page = collection.next_page
    next_page_url = send(links_paths, page: next_page)
    current_page = collection.current_page

    {
      links: {
        pagination: {
          first_page_url: send(links_paths, page: 1),
          from: to_page_i - items_per_page.to_i + 1,
          to: to_page_i,
          items_per_page: items_per_page.to_i,
          last_page: total_pages,
          next_page_url: next_page_url,
          page: current_page,
          prev_page_url: prev_page_url,
          total: total_pages,
          links: [
            {
              active: prev_page == current_page,
              label: '&laquo; Previous',
              page: prev_page,
              url: prev_page_url
            },
            {
              active: current_page == current_page,
              label: current_page.to_s,
              page: current_page,
              url: send(links_paths, page: current_page)
            },
            {
              active: current_page + 1 == current_page,
              label: (current_page + 1).to_s,
              page: current_page + 1,
              url: send(links_paths, page: current_page + 1)
            },
            {
              active: current_page + 2 == current_page,
              label: (current_page + 2).to_s,
              page: current_page + 2,
              url: send(links_paths, page: current_page + 2)
            },
            {
              active: next_page == current_page,
              label: 'Next &raquo;',
              page: next_page,
              url: send(links_paths, page: next_page)
            }
          ]
        }
      }
    }
  end
end
