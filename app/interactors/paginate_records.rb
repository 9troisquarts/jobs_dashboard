class PaginateRecords
  include Interactor

  around do |interactor|
    if context.records.nil?
      context.fail!(message: 'Records must be provided')
    else
      interactor.call
    end
  end

  def call
    # Define default params and merge with params provided
    params = context.pagination_params || {}
    params = { per_page: 25, page: 1 }.merge(params)

    context.total_pages = 1
    context.current_page = 1
    context.per_page = params[:per_page].to_i || 25

    records = context.records
    context.records_count = records.size
    records = Kaminari.paginate_array(records) if records.is_a?(Array)
    records = records.page(params[:page]).per(context.per_page)
    # Kaminari methods for get total pages and current page
    context.total_pages = records.total_pages.to_i
    context.current_page = records.current_page.to_i
    context.records = records
  end
end
