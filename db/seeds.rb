admin = User.find_or_initialize_by(email: "admin@concurseiro.local")

admin.assign_attributes(
  name: "Administrador",
  password: "Admin123!",
  password_confirmation: "Admin123!",
  role: :admin,
  active: true
)

admin.save!

puts "Administrador criado: #{admin.email}"



# ---------------------------------------------------------
# Dados iniciais para desenvolvimento
# ---------------------------------------------------------

cebraspe = ExamBoard.find_or_create_by!(name: "Centro Brasileiro de Pesquisa em Avaliação e Seleção e de Promoção de Eventos") do |board|
  board.acronym = "CEBRASPE"
end

cesgranrio = ExamBoard.find_or_create_by!(name: "Fundação Cesgranrio") do |board|
  board.acronym = "CESGRANRIO"
end

prf = Institution.find_or_create_by!(name: "Polícia Rodoviária Federal") do |institution|
  institution.acronym = "PRF"
end

policial = Position.find_or_create_by!(
  name: "Policial Rodoviário Federal"
)

raciocinio_logico = Subject.find_or_create_by!(
  name: "Raciocínio Lógico"
)

portugues = Subject.find_or_create_by!(
  name: "Língua Portuguesa"
)

direito_constitucional = Subject.find_or_create_by!(
  name: "Direito Constitucional"
)

# ---------------------------------------------------------
# Assuntos
# ---------------------------------------------------------

logica_proposicional = Topic.find_or_create_by!(
  name: "Lógica Proposicional",
  subject: raciocinio_logico,
  parent: nil
)

tabelas_verdade = Topic.find_or_create_by!(
  name: "Tabelas-Verdade",
  subject: raciocinio_logico,
  parent: logica_proposicional
)

equivalencias = Topic.find_or_create_by!(
  name: "Equivalências Lógicas",
  subject: raciocinio_logico,
  parent: logica_proposicional
)

interpretacao = Topic.find_or_create_by!(
  name: "Interpretação de Textos",
  subject: portugues,
  parent: nil
)

direitos_fundamentais = Topic.find_or_create_by!(
  name: "Direitos e Garantias Fundamentais",
  subject: direito_constitucional,
  parent: nil
)

# ---------------------------------------------------------
# Prova
# ---------------------------------------------------------

exam = Exam.find_or_create_by!(
  name: "PRF 2021 - Policial Rodoviário Federal",
  year: 2021,
  exam_board: cebraspe,
  institution: prf,
  position: policial
) do |e|
  e.level = :higher_education
end

# ---------------------------------------------------------
# Questão 1
# ---------------------------------------------------------

question1 = Question.find_or_initialize_by(
  exam: exam,
  number: 1
)

question1.assign_attributes(
  subject: raciocinio_logico,
  statement: "Considere as proposições P e Q. Se P é verdadeira e Q é falsa, então a proposição P e Q é verdadeira.",
  modality: :true_false,
  difficulty: :easy,
  correct_answer: "E",
  status: :published,
  annulled: false,
  outdated: false
)

question1.save!

QuestionTopic.find_or_create_by!(
  question: question1,
  topic: tabelas_verdade
)

QuestionTopic.find_or_create_by!(
  question: question1,
  topic: logica_proposicional
)

# ---------------------------------------------------------
# Questão 2
# ---------------------------------------------------------

question2 = Question.find_or_initialize_by(
  exam: exam,
  number: 2
)

question2.assign_attributes(
  subject: portugues,
  statement: "A interpretação de um texto deve considerar não apenas informações explícitas, mas também inferências permitidas pelo contexto.",
  modality: :true_false,
  difficulty: :medium,
  correct_answer: "C",
  status: :published,
  annulled: false,
  outdated: false
)

question2.save!

QuestionTopic.find_or_create_by!(
  question: question2,
  topic: interpretacao
)

# ---------------------------------------------------------
# Questão 3
# ---------------------------------------------------------

question3 = Question.find_or_initialize_by(
  exam: exam,
  number: 3
)

question3.assign_attributes(
  subject: direito_constitucional,
  statement: "Os direitos e garantias fundamentais previstos na Constituição Federal possuem aplicação imediata.",
  modality: :true_false,
  difficulty: :medium,
  correct_answer: "C",
  status: :published,
  annulled: false,
  outdated: false
)

question3.save!

QuestionTopic.find_or_create_by!(
  question: question3,
  topic: direitos_fundamentais
)

puts "Seeds concluídos."
puts "Bancas: #{ExamBoard.count}"
puts "Instituições: #{Institution.count}"
puts "Disciplinas: #{Subject.count}"
puts "Assuntos: #{Topic.count}"
puts "Provas: #{Exam.count}"
puts "Questões: #{Question.count}"