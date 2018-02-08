defmodule FirstDaysWeb.EmailView do
  use FirstDaysWeb, :view

  @humanised_documents %{
    photo_id: "Photo id",
    proof_of_identity: "Proof of identity",
    proof_of_address: "Proof of address",
    volunteer_requirements: "Volunteer requirements e.g. dietary, medical or religious needs",
    emergency_contact_details: "Emergency contact details",
    dbs_check: "DBS (Disclosure and Barring Service) check",
    proof_of_residency: "Proof of residency",
    bank_details: "Bank/Building Society details (for paying expenses)",
    proof_of_qualifications: "Proof of qualifications"
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
