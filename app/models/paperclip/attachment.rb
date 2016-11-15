class Paperclip::Attachment

  def file_path
    path(:original).try(:gsub, ":domain", Tenant.current_tenant.domain.to_s)
  end

  def file_exists?
    file_path && File.exists?(file_path)
  end

end