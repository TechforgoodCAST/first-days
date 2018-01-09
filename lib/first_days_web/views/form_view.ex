defmodule FirstDaysWeb.FormView do
  use FirstDaysWeb, :view

  def finance_skills do
    [
    "Day to day bookkeeping. e.g. managing receipts, petty cash etc",
    "Analysing/communicating management accounts e.g. to the trustees",
    "Financial forecasting",
    "Payroll",
    "Pensions, Insurances, Investments"
    ]
  end

  def documents do
    [
    "Photo id",
    "Proof of identity",
    "Proof of address",
    "Volunteer requirements e.g. dietary, medical or religious needs",
    "Emergency contact details",
    "DBS (Disclosure and Barring Service) check",
    "Proof of residency",
    "Bank/Building Society details (for paying expenses)",
    "Proof of qualifications"
    ]
  end
end
