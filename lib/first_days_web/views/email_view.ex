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
  
  def digitsToMonth(1), do: "January"
  def digitsToMonth(2), do: "February"
  def digitsToMonth(3), do: "March"
  def digitsToMonth(4), do: "April"
  def digitsToMonth(5), do: "May"
  def digitsToMonth(6), do: "June"
  def digitsToMonth(7), do: "July"
  def digitsToMonth(8), do: "August"
  def digitsToMonth(9), do: "September"
  def digitsToMonth(10), do: "October"
  def digitsToMonth(11), do: "November"
  def digitsToMonth(12), do: "December"
end
