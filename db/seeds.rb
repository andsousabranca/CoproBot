# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


puts "Destroying all Message data"
Message.destroy_all
puts "Destroying all Chats data"
Chat.destroy_all
puts "Destroying all User data"
User.destroy_all
puts "Destroying all Section data"
Section.destroy_all

Section.create(:content => "
  Instruction:
  Always base your answers on the following GDPR framework when discussing personal data, data protection, or related compliance topics in the EU, specifically Belgium. Be precise, clear, and provide practical guidance when relevant.

  Scope & Applicability:

  Applies to EU-based companies processing personal data, regardless of processing location.

  Applies to non-EU companies offering goods/services to or monitoring individuals in the EU.

  Non-EU businesses must appoint an EU representative.

  Exclusions: deceased individuals, legal persons, or personal data processed outside trade/profession.

  Personal Data:

  Any information identifying an individual: name, address, ID, income, IP, health data, cultural profile, etc.

  Special categories: racial/ethnic origin, political/religious beliefs, trade-union membership, genetic/biometric/health data, criminal data (restricted processing, usually requiring consent or law).

  Roles & Responsibilities:

  Data Controller: decides purpose/method of processing.

  Data Processor: handles data on behalf of controller.

  Data Protection Officer (DPO): monitors compliance, advises staff, liaises with DPA.

  DPO required if processing special categories, large-scale processing, or core business activity.

  Legal Basis for Processing:

  Lawful, fair, purpose-specific, and minimal.

  Based on: consent, contract, legal obligation, vital interests, public task, legitimate interest (if rights not overridden).

  Consent must be freely given, specific, informed, unambiguous, and withdrawable.

  Transparency & Communication:

  Inform data subjects about: controller, purpose, legal basis, recipients, retention, rights, automated decisions, DPO contact if applicable.

  For children, parental consent is required (age 13–16 depending on jurisdiction).

  Individual Rights:

  Access & portability: provide data in accessible format.

  Correction & objection: rectify errors, notify recipients, stop processing if objection valid.

  Erasure: allowed unless legal/public interest/contractual reasons apply.

  Automated decisions & profiling: right to human review, contestation, explanation.

  Data Transfers Outside EU:

  Ensure GDPR protection via adequacy decision, contractual safeguards, or consent/derogations.

  Data Breaches:

  Notify DPA within 72 hours if rights/freedoms at risk.

  Notify affected individuals if high risk.

  Record-Keeping & Compliance:

  Maintain detailed processing records (purpose, categories, recipients, transfers, retention, security).

  SMEs may be exempt if processing is occasional, low risk, non-sensitive.

  Data Protection by Design & Default:

  Build privacy protections from planning stage.

  Use most privacy-friendly default settings (e.g., pseudonymisation).

  Penalties:

  Fines up to €20 million or 4% of global turnover, plus corrective measures.
  ",
  :system_prompt => "
    You are an experienced Building Manager, specialised in Belgium Co-ownerships.

    I am an appartement Owner, looking to learn about the Co-Ownership rules and regulations.

    Guide me into the RGPD regulations concerning data usage for co-ownerships.

    Provide step-by-step instructions in bullet points, using Markdown.
  ",
  :name => "GDPR"
)

Section.create(:content => "
  Instruction:
  HAS TO BE COMPLETED
  ",
  :system_prompt => "
    You are an experienced Building Manager, specialised in Belgium Co-ownerships.

    I am an appartement Owner, looking to learn about the Co-Ownership rules and regulations.

    Guide me into the financial side concerning accountancy for co-ownerships.

    Provide step-by-step instructions in bullet points, using Markdown.
  ",
  :name => "Accounting & Financial Management"
)

Section.create(:content => "
  Instruction:
  HAS TO BE COMPLETED
  ",
  :system_prompt => "
    You are an experienced Building Manager, specialised in Belgium Co-ownerships.

    I am an appartement Owner, looking to learn about the Co-Ownership rules and regulations.

    Guide me into the financial side concerning accountancy for co-ownerships.

    Provide step-by-step instructions in bullet points, using Markdown.
  ",
  :name => "Co-Ownership (Legal & Governance)"
)

Section.create(:content => "
  Instruction:
  HAS TO BE COMPLETED
  ",
  :system_prompt => "
    You are an experienced Building Manager, specialised in Belgium Co-ownerships.

    I am an appartement Owner, looking to learn about the Co-Ownership rules and regulations.

    Guide me into the financial side concerning accountancy for co-ownerships.

    Provide step-by-step instructions in bullet points, using Markdown.
  ",
  :name => "Building Maintenance & Safety"
)

puts Section.count

User.create(email: "test@test.de", password: "123123")
puts User.count

Chat.create(user: User.first, section: Section.first, title: "Law is important")
Chat.create(user: User.first, section: Section.first, title: "GDPR is very essential")
Chat.create(user: User.first, section: Section.first, title: "New chat")
puts Chat.count

Message.create(role: "user", content: "Today is a beautiful day", chat: Chat.last)
Message.create(role: "assistant", content: "I agree, so beautiful", chat: Chat.last)
Message.create(role: "user", content: "Did you have coffee today?", chat: Chat.last)
Message.create(role: "assistant", content: "Yes, I had.", chat: Chat.last)
puts Message.count