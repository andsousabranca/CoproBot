CoproBot

AI-powered expert assistant for Belgian co-ownership (copropriété) management. Built for apartment owners, syndics, and anyone navigating the legal, financial, and technical complexity of co-owned residential buildings in Belgium.

Live demo: https://coprobot-pke.sliplane.app/

What it does

Users pick a specialist domain, start a conversation, and get plain-language answers grounded in Belgian law — streamed in real time. Each domain has its own AI agent with a dedicated system prompt and knowledge base.

The 4 specialist agents:
- GDPR — data protection rules specific to Belgian co-ownerships
- Accounting & Financial Management — budgets, charges, accounts
- Co-Ownership (Legal & Governance) — Belgian Civil Code, ACP rules
- Building Maintenance & Safety — technical and regulatory obligations

Tech stack

Ruby on Rails 7.1 · PostgreSQL · Hotwire (Turbo + Stimulus) · Tailwind CSS · DaisyUI · Devise · Docker · Deployed on Sliplane

AI: ruby_llm gem · Real-time streaming via Turbo Streams + Action Cable

Features

- Specialist AI agents per domain with persistent chat history
- Real-time token-by-token streaming responses
- Markdown rendering with syntax highlighting
- Auto-generated conversation titles
- Multi-session support per user per domain

Getting started

git clone https://github.com/pkeane93/CoproBot_pke
cd CoproBot_pke
bundle install
rails db:create db:migrate db:seed
rails server

Set your environment variables:
GITHUB_TOKEN=your_token
