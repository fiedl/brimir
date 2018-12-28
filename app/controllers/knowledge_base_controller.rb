class KnowledgeBaseController < ApplicationController

  def index
    authorize! :index, :knowledge_base

    @labels = labels_with_corresponding_email_template
  end

  private

  def labels_with_corresponding_email_template
    Label.where(name: EmailTemplate.where(kind: :canned_reply).where.not(message: [nil, ""]).pluck(:name))
  end

end