defmodule FirstDaysWeb.EmailView do
  use FirstDaysWeb, :view

  def humanised_documents do
    %{
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
  end

  def get_document_list(documents) do
    documents
    |> Map.from_struct
    |> Map.drop([:id, :other_document])
    |> Map.to_list
    |> Enum.filter(fn({_doc, string_bool}) -> string_bool != false end)
    |> Enum.map(fn({doc, _string_bool}) -> Map.get(humanised_documents(), doc) end)
  end

  def digitsToMonth(1), do: gettext("January")
  def digitsToMonth(2), do: gettext("February")
  def digitsToMonth(3), do: gettext("March")
  def digitsToMonth(4), do: gettext("April")
  def digitsToMonth(5), do: gettext("May")
  def digitsToMonth(6), do: gettext("June")
  def digitsToMonth(7), do: gettext("July")
  def digitsToMonth(8), do: gettext("August")
  def digitsToMonth(9), do: gettext("September")
  def digitsToMonth(10), do: gettext("October")
  def digitsToMonth(11), do: gettext("November")
  def digitsToMonth(12), do: gettext("December")
end
