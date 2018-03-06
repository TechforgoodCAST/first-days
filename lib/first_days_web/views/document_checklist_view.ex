defmodule FirstDaysWeb.DocumentChecklistView do
  use FirstDaysWeb, :view

  @humanised_documents %{
    photo_id: gettext("Photo id"),
    proof_of_identity: gettext("Proof of identity"),
    proof_of_address: gettext("Proof of address"),
    volunteer_requirements: gettext("Volunteer requirements e.g. dietary, medical or religious needs"),
    emergency_contact_details: gettext("Emergency contact details"),
    dbs_check: gettext("DBS (Disclosure and Barring Service) check"),
    proof_of_residency: gettext("Proof of residency"),
    bank_details: gettext("Bank/Building Society details (for paying expenses)"),
    proof_of_qualifications: gettext("Proof of qualifications")
  }

  def get_document_list(documents) do
    documents
    |> Map.from_struct
    |> Map.drop([:id, :other_document])
    |> Map.to_list
    |> Enum.filter(fn({_doc, string_bool}) -> string_bool != false end)
    |> Enum.map(fn({doc, _string_bool}) -> Map.get(@humanised_documents, doc) end)
  end
end
