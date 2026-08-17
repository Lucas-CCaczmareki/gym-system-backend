-- zera tudo toda vez q eu for rodar o seed.sql. util pra ir testando nesse começo
TRUNCATE TABLE usr, exercise, muscle, mscl_activation, routine, workout,
    routine_workout, plan, session, execution, training_set, equipment
    RESTART IDENTITY CASCADE;

CREATE EXTENSION IF NOT EXISTS pgcrypto;

INSERT INTO usr (email, "name", senha, f_active) VALUES
    ('admin@gmail.com',             'Admin',            crypt ('admin123', gen_salt('bf')), TRUE),
    ('lucascaczmareki@gmail.com',   'Lucas Caczmareki', crypt ('lucas123', gen_salt('bf')), TRUE),
    ('joao@gmail.com',              'Joao Godinho',     crypt ('joao123', gen_salt('bf')),  TRUE);
    
INSERT INTO equipment ("name", base_weight) VALUES
    ('Barbell', 10),            --1
    ('Olympic barbell', 20),    --2
    ('Smith', 5),               --3
    ('Pulley', 0),              --4
    ('Machine', 5),             --5
    ('Dumbbell', 0),            --6
    ('Bodyweight', 0);          --7

INSERT INTO muscle ("name") VALUES
    ('Peitoral'),
    ('Deltoide'),
    ('Tríceps'),
    ('Bíceps'),
    ('Dorsais'),
    ('Romboides'),
    ('Trapézio'),
    ('Lombar'),
    ('Antebraço'),
    ('Quadríceps'),
    ('Isquiotibiais'),
    ('Glúteo'),
    ('Adutores'),
    ('Panturrilha'),
    ('Abdômen'),
    ('Flexores de quadril');

-- -----------------------------------------------------------------------------------------------
-- Isso aqui foi gerado por IA (e revisado) com base na base de exercícios no "exercises.md" que eu criei.
-- deve ter jeitos mais inteligentes de fazer depois, vou estudar. Um amigo me recomendou ORM insert.

INSERT INTO exercise ("name", "type", idEquipment, f_oneside) VALUES
    -- Peito
    ('Supino reto', 'compound', (SELECT id FROM equipment WHERE name = 'Barbell'), FALSE),
    ('Supino reto', 'compound', (SELECT id FROM equipment WHERE name = 'Olympic barbell'), FALSE),
    ('Supino reto', 'compound', (SELECT id FROM equipment WHERE name = 'Smith'), FALSE),
    ('Supino reto', 'compound', (SELECT id FROM equipment WHERE name = 'Machine'), FALSE),
    ('Supino reto', 'compound', (SELECT id FROM equipment WHERE name = 'Dumbbell'), FALSE),

    ('Supino inclinado', 'compound', (SELECT id FROM equipment WHERE name = 'Barbell'), FALSE),
    ('Supino inclinado', 'compound', (SELECT id FROM equipment WHERE name = 'Olympic barbell'), FALSE),
    ('Supino inclinado', 'compound', (SELECT id FROM equipment WHERE name = 'Smith'), FALSE),
    ('Supino inclinado', 'compound', (SELECT id FROM equipment WHERE name = 'Machine'), FALSE),
    ('Supino inclinado', 'compound', (SELECT id FROM equipment WHERE name = 'Dumbbell'), FALSE),

    ('Supino declinado', 'compound', (SELECT id FROM equipment WHERE name = 'Barbell'), FALSE),
    ('Supino declinado', 'compound', (SELECT id FROM equipment WHERE name = 'Olympic barbell'), FALSE),
    ('Supino declinado', 'compound', (SELECT id FROM equipment WHERE name = 'Smith'), FALSE),
    ('Supino declinado', 'compound', (SELECT id FROM equipment WHERE name = 'Machine'), FALSE),
    ('Supino declinado', 'compound', (SELECT id FROM equipment WHERE name = 'Dumbbell'), FALSE),

    ('Mergulho em paralela', 'compound', (SELECT id FROM equipment WHERE name = 'Bodyweight'), FALSE),
    ('Mergulho em paralela', 'compound', (SELECT id FROM equipment WHERE name = 'Machine'), FALSE), --num graviton por exemplo
    
    ('Crucifixo', 'isolated', (SELECT id FROM equipment WHERE name = 'Dumbbell'), FALSE),
    ('Crucifixo inclinado', 'isolated', (SELECT id FROM equipment WHERE name = 'Dumbbell'), FALSE),
    ('Crucifixo declinado', 'isolated', (SELECT id FROM equipment WHERE name = 'Dumbbell'), FALSE),

    ('Crucifixo', 'isolated', (SELECT id FROM equipment WHERE name = 'Machine'), FALSE),
    ('Crucifixo inclinado', 'isolated', (SELECT id FROM equipment WHERE name = 'Machine'), FALSE), -- no peckdeck impossivel, mas tem máquinas pra isso
    ('Crucifixo declinado', 'isolated', (SELECT id FROM equipment WHERE name = 'Machine'), FALSE), -- variação da posição do banco no peck deck por exemplo
    
    ('Crossover', 'isolated', (SELECT id FROM equipment WHERE name = 'Pulley'), FALSE),            -- mesmo exercicio mas muda de nome
    ('Crossover inclinado', 'isolated', (SELECT id FROM equipment WHERE name = 'Pulley'), FALSE),  -- dá pra chamar de crossover polia baixa
    ('Crossover declinado', 'isolated', (SELECT id FROM equipment WHERE name = 'Pulley'), FALSE),  -- da pra chamar de crossover polia alta

    -- Costas
    ('Barra fixa', 'compound', (SELECT id FROM equipment WHERE name = 'Bodyweight'), FALSE),
    ('Barra fixa', 'compound', (SELECT id FROM equipment WHERE name = 'Machine'), FALSE),      -- graviton
    ('Pulley frente', 'compound', (SELECT id FROM equipment WHERE name = 'Pulley'), FALSE),    -- mesmo exercicio mas muda de nome

    ('Face pull', 'isolated', (SELECT id FROM equipment WHERE name = 'Pulley'), FALSE),

    ('Pulldown', 'isolated', (SELECT id FROM equipment WHERE name = 'Pulley'), FALSE),
    ('Pulldown', 'isolated', (SELECT id FROM equipment WHERE name = 'Machine'), FALSE),

    ('Remada baixa', 'compound', (SELECT id FROM equipment WHERE name = 'Pulley'), FALSE),
    ('Remada baixa', 'compound', (SELECT id FROM equipment WHERE name = 'Pulley'), TRUE), --unilateral
    ('Remada baixa', 'compound', (SELECT id FROM equipment WHERE name = 'Machine'), FALSE),
    ('Remada baixa', 'compound', (SELECT id FROM equipment WHERE name = 'Machine'), TRUE), --unilateral
    
    ('Remada curvada', 'compound', (SELECT id FROM equipment WHERE name = 'Barbell'), FALSE),
    ('Remada curvada', 'compound', (SELECT id FROM equipment WHERE name = 'Olympic barbell'), FALSE),
    ('Remada curvada', 'compound', (SELECT id FROM equipment WHERE name = 'Dumbbell'), FALSE),
    ('Remada curvada', 'compound', (SELECT id FROM equipment WHERE name = 'Machine'), FALSE),

    ('Remada cavalinho', 'compound', (SELECT id FROM equipment WHERE name = 'Barbell'), FALSE),
    ('Remada cavalinho', 'compound', (SELECT id FROM equipment WHERE name = 'Machine'), FALSE),

    ('Remada serrote', 'compound', (SELECT id FROM equipment WHERE name = 'Dumbbell'), TRUE),

    ('Remada articulada', 'compound', (SELECT id FROM equipment WHERE name = 'Pulley'), FALSE),
    ('Remada articulada', 'compound', (SELECT id FROM equipment WHERE name = 'Machine'), FALSE),

    -- Ombro
    ('Desenvolvimento militar', 'compound', (SELECT id FROM equipment WHERE name = 'Barbell'), FALSE),
    ('Desenvolvimento militar', 'compound', (SELECT id FROM equipment WHERE name = 'Olympic barbell'), FALSE),
    ('Desenvolvimento militar', 'compound', (SELECT id FROM equipment WHERE name = 'Smith'), FALSE),
    ('Desenvolvimento com halteres', 'compound', (SELECT id FROM equipment WHERE name = 'Dumbbell'), FALSE),
    ('Desenvolvimento Arnold', 'compound', (SELECT id FROM equipment WHERE name = 'Dumbbell'), FALSE),

    ('Elevação lateral', 'isolated', (SELECT id FROM equipment WHERE name = 'Dumbbell'), FALSE),
    ('Elevação lateral', 'isolated', (SELECT id FROM equipment WHERE name = 'Pulley'), FALSE),
    ('Elevação lateral', 'isolated', (SELECT id FROM equipment WHERE name = 'Machine'), FALSE),

    ('Remada alta', 'isolated', (SELECT id FROM equipment WHERE name = 'Dumbbell'), TRUE),
    ('Remada alta', 'isolated', (SELECT id FROM equipment WHERE name = 'Pulley'), TRUE),

    ('Elevação frontal', 'isolated', (SELECT id FROM equipment WHERE name = 'Dumbbell'), FALSE),
    ('Elevação frontal', 'isolated', (SELECT id FROM equipment WHERE name = 'Pulley'), FALSE),

    ('Encolhimento', 'isolated', (SELECT id FROM equipment WHERE name = 'Barbell'), FALSE),
    ('Encolhimento', 'isolated', (SELECT id FROM equipment WHERE name = 'Dumbbell'), FALSE),
    ('Encolhimento', 'isolated', (SELECT id FROM equipment WHERE name = 'Smith'), FALSE),

    ('Crucifixo invertido', 'isolated', (SELECT id FROM equipment WHERE name = 'Machine'), FALSE),
    ('Crucifixo invertido', 'isolated', (SELECT id FROM equipment WHERE name = 'Pulley'), FALSE),

    
    -- não vou botar os unilaterais aqui por que não vai influenciar o peso.
    -- Biceps
    ('Rosca direta', 'isolated', (SELECT id FROM equipment WHERE name = 'Barbell'), FALSE),
    ('Rosca direta', 'isolated', (SELECT id FROM equipment WHERE name = 'Olympic barbell'), FALSE),
    ('Rosca direta', 'isolated', (SELECT id FROM equipment WHERE name = 'Dumbbell'), FALSE),
    ('Rosca direta', 'isolated', (SELECT id FROM equipment WHERE name = 'Pulley'), FALSE),

    ('Rosca martelo', 'isolated', (SELECT id FROM equipment WHERE name = 'Dumbbell'), FALSE),
    ('Rosca martelo', 'isolated', (SELECT id FROM equipment WHERE name = 'Pulley'), FALSE),

    ('Rosca alternada', 'isolated', (SELECT id FROM equipment WHERE name = 'Dumbbell'), FALSE),
    ('Rosca alternada', 'isolated', (SELECT id FROM equipment WHERE name = 'Pulley'), FALSE), --basicamente a martelo puxando pra fora no pulley c corda

    ('Rosca Scott', 'isolated', (SELECT id FROM equipment WHERE name = 'Machine'), FALSE),
    ('Rosca Scott', 'isolated', (SELECT id FROM equipment WHERE name = 'Barbell'), FALSE),
    ('Rosca Scott', 'isolated', (SELECT id FROM equipment WHERE name = 'Dumbbell'), FALSE),

    ('Rosca concentrada', 'isolated', (SELECT id FROM equipment WHERE name = 'Dumbbell'), FALSE),

    ('Rosca polia alta', 'isolated', (SELECT id FROM equipment WHERE name = 'Pulley'), FALSE),

    ('Rosca Bayesiana', 'isolated', (SELECT id FROM equipment WHERE name = 'Pulley'), FALSE),

    ('Rosca inclinada', 'isolated', (SELECT id FROM equipment WHERE name = 'Dumbbell'), FALSE),

    ('Rosca spider', 'isolated', (SELECT id FROM equipment WHERE name = 'Barbell'), FALSE),
    ('Rosca spider', 'isolated', (SELECT id FROM equipment WHERE name = 'Olympic barbell'), FALSE),
    ('Rosca spider', 'isolated', (SELECT id FROM equipment WHERE name = 'Dumbbell'), FALSE),
    

    -- Triceps
    ('Tríceps pulley', 'isolated', (SELECT id FROM equipment WHERE name = 'Pulley'), FALSE),
    ('Tríceps pulley', 'isolated', (SELECT id FROM equipment WHERE name = 'Pulley'), TRUE), --esse unilateral muda a carga

    ('Tríceps testa', 'isolated', (SELECT id FROM equipment WHERE name = 'Barbell'), FALSE),
    ('Tríceps testa', 'isolated', (SELECT id FROM equipment WHERE name = 'Olympic barbell'), FALSE),
    ('Tríceps testa', 'isolated', (SELECT id FROM equipment WHERE name = 'Dumbbell'), FALSE),
    ('Tríceps testa', 'isolated', (SELECT id FROM equipment WHERE name = 'Pulley'), FALSE),
    ('Tríceps testa', 'isolated', (SELECT id FROM equipment WHERE name = 'Pulley'), TRUE), --unilat

    ('Tríceps francês', 'isolated', (SELECT id FROM equipment WHERE name = 'Barbell'), FALSE),
    ('Tríceps francês', 'isolated', (SELECT id FROM equipment WHERE name = 'Olympic barbell'), FALSE),
    ('Tríceps francês', 'isolated', (SELECT id FROM equipment WHERE name = 'Dumbbell'), FALSE),
    ('Tríceps francês', 'isolated', (SELECT id FROM equipment WHERE name = 'Pulley'), FALSE),
    ('Tríceps francês', 'isolated', (SELECT id FROM equipment WHERE name = 'Pulley'), TRUE), --unilat

    ('Tríceps coice', 'isolated', (SELECT id FROM equipment WHERE name = 'Dumbbell'), FALSE),
    ('Tríceps coice', 'isolated', (SELECT id FROM equipment WHERE name = 'Pulley'), FALSE),
    ('Tríceps coice', 'isolated', (SELECT id FROM equipment WHERE name = 'Pulley'), TRUE),

    ('Supino fechado', 'compound', (SELECT id FROM equipment WHERE name = 'Barbell'), FALSE),
    ('Supino fechado', 'compound', (SELECT id FROM equipment WHERE name = 'Olympic barbell'), FALSE),


    -- Quadríceps
    ('Agachamento', 'compound', (SELECT id FROM equipment WHERE name = 'Barbell'), FALSE),
    ('Agachamento', 'compound', (SELECT id FROM equipment WHERE name = 'Olympic barbell'), FALSE),
    ('Agachamento', 'compound', (SELECT id FROM equipment WHERE name = 'Smith'), FALSE),
    ('Agachamento', 'compound', (SELECT id FROM equipment WHERE name = 'Bodyweight'), FALSE),

    ('Agachamento hack', 'compound', (SELECT id FROM equipment WHERE name = 'Machine'), FALSE),
    ('Agachamento pêndulo', 'compound', (SELECT id FROM equipment WHERE name = 'Machine'), FALSE),

    ('Leg press 45', 'compound', (SELECT id FROM equipment WHERE name = 'Machine'), FALSE),
    ('Leg press 90', 'compound', (SELECT id FROM equipment WHERE name = 'Machine'), FALSE),
    ('Leg press 180', 'compound', (SELECT id FROM equipment WHERE name = 'Machine'), FALSE),


    ('Cadeira extensora', 'isolated', (SELECT id FROM equipment WHERE name = 'Machine'), FALSE),
    ('Cadeira extensora', 'isolated', (SELECT id FROM equipment WHERE name = 'Machine'), TRUE),

    ('Afundo', 'compound', (SELECT id FROM equipment WHERE name = 'Bodyweight'), FALSE),
    ('Afundo', 'compound', (SELECT id FROM equipment WHERE name = 'Dumbbell'), FALSE), -- tudo no chão

    ('Agachamento búlgaro', 'compound', (SELECT id FROM equipment WHERE name = 'Bodyweight'), FALSE),
    ('Agachamento búlgaro', 'compound', (SELECT id FROM equipment WHERE name = 'Dumbbell'), FALSE), -- apoiado no banco
    ('Agachamento búlgaro', 'compound', (SELECT id FROM equipment WHERE name = 'Smith'), FALSE),

    -- Posterior de coxa
    ('Levantamento terra', 'compound', (SELECT id FROM equipment WHERE name = 'Barbell'), FALSE),
    ('Levantamento terra', 'compound', (SELECT id FROM equipment WHERE name = 'Olympic barbell'), FALSE),
    ('Levantamento terra', 'compound', (SELECT id FROM equipment WHERE name = 'Machine'), FALSE),

    ('Levantamento terra romeno', 'compound', (SELECT id FROM equipment WHERE name = 'Barbell'), FALSE),
    ('Levantamento terra romeno', 'compound', (SELECT id FROM equipment WHERE name = 'Olympic barbell'), FALSE),
    ('Levantamento terra romeno', 'compound', (SELECT id FROM equipment WHERE name = 'Dumbbell'), FALSE),
    ('Levantamento terra romeno', 'compound', (SELECT id FROM equipment WHERE name = 'Machine'), FALSE),

    ('Levantamento terra stiff', 'compound', (SELECT id FROM equipment WHERE name = 'Barbell'), FALSE),
    ('Levantamento terra stiff', 'compound', (SELECT id FROM equipment WHERE name = 'Olympic barbell'), FALSE),
    ('Levantamento terra stiff', 'compound', (SELECT id FROM equipment WHERE name = 'Dumbbell'), FALSE),
    ('Levantamento terra stiff', 'compound', (SELECT id FROM equipment WHERE name = 'Machine'), FALSE),

    ('Agachamento sumô', 'compound', (SELECT id FROM equipment WHERE name = 'Bodyweight'), FALSE),
    ('Agachamento sumô', 'compound', (SELECT id FROM equipment WHERE name = 'Barbell'), FALSE),
    ('Agachamento sumô', 'compound', (SELECT id FROM equipment WHERE name = 'Olympic barbell'), FALSE),
    ('Agachamento sumô', 'compound', (SELECT id FROM equipment WHERE name = 'Dumbbell'), FALSE),
    ('Agachamento sumô', 'compound', (SELECT id FROM equipment WHERE name = 'Machine'), FALSE),

    ('Cadeira flexora', 'isolated', (SELECT id FROM equipment WHERE name = 'Machine'), FALSE),
    ('Cama flexora', 'isolated', (SELECT id FROM equipment WHERE name = 'Machine'), FALSE),
    ('Cama flexora em pé', 'isolated', (SELECT id FROM equipment WHERE name = 'Machine'), FALSE),

    ('Good morning', 'compound', (SELECT id FROM equipment WHERE name = 'Barbell'), FALSE),
    ('Good morning', 'compound', (SELECT id FROM equipment WHERE name = 'Olympic barbell'), FALSE),

    -- Gluteos, adutores e abdutores
    ('Elevação pélvica', 'compound', (SELECT id FROM equipment WHERE name = 'Barbell'), FALSE),
    ('Elevação pélvica', 'compound', (SELECT id FROM equipment WHERE name = 'Machine'), FALSE),
    ('Elevação pélvica', 'compound', (SELECT id FROM equipment WHERE name = 'Bodyweight'), FALSE),

    ('Cadeira abdutora', 'isolated', (SELECT id FROM equipment WHERE name = 'Machine'), FALSE),
    ('Cadeira adutora', 'isolated', (SELECT id FROM equipment WHERE name = 'Machine'), FALSE),

    -- Panturrilha
    ('Panturrilha em pé', 'isolated', (SELECT id FROM equipment WHERE name = 'Machine'), FALSE),
    ('Panturrilha em pé', 'isolated', (SELECT id FROM equipment WHERE name = 'Machine'), TRUE),
    ('Panturrilha em pé', 'isolated', (SELECT id FROM equipment WHERE name = 'Smith'), FALSE),
    ('Panturrilha em pé', 'isolated', (SELECT id FROM equipment WHERE name = 'Smith'), TRUE),
    ('Panturrilha em pé', 'isolated', (SELECT id FROM equipment WHERE name = 'Bodyweight'), FALSE),
    ('Panturrilha em pé', 'isolated', (SELECT id FROM equipment WHERE name = 'Bodyweight'), TRUE),

    ('Panturrilha sentado', 'isolated', (SELECT id FROM equipment WHERE name = 'Machine'), FALSE),

    -- Core, abs
    ('Abdominal declinado', 'isolated', (SELECT id FROM equipment WHERE name = 'Bodyweight'), FALSE),
    ('Abdominal na corda', 'isolated', (SELECT id FROM equipment WHERE name = 'Pulley'), FALSE),
    ('Abdominal suspenso', 'isolated', (SELECT id FROM equipment WHERE name = 'Bodyweight'), FALSE),
    ('Abdominal dragonflag', 'isolated', (SELECT id FROM equipment WHERE name = 'Bodyweight'), FALSE),

    ('Prancha', 'isolated', (SELECT id FROM equipment WHERE name = 'Bodyweight'), FALSE),

    ('Hiperextensão lombar', 'isolated', (SELECT id FROM equipment WHERE name = 'Machine'), FALSE),
    ('Hiperextensão lombar', 'isolated', (SELECT id FROM equipment WHERE name = 'Bodyweight'), FALSE);

-- -----------------------------------------------------------------------------------------------
-- Insert de ativação muscular
INSERT INTO mscl_activation (idExercise, idMuscle, "role")

-- os "::" é um casting do tipo v.role_ pra minha enum. Necessário por conta da tabela temporária
SELECT e.id, m."name", v.role_::muscle_role 

-- cria uma tabela virtual em memória durante a inserção pra ter a relação exercício, musculo, role por nome
FROM (VALUES
    -- Peito
    ('Supino reto', 'Peitoral', 'primary'),
    ('Supino reto', 'Deltoide', 'secondary'),
    ('Supino reto', 'Tríceps', 'secondary'),
    ('Supino inclinado', 'Peitoral', 'primary'),
    ('Supino inclinado', 'Deltoide', 'secondary'),
    ('Supino inclinado', 'Tríceps', 'secondary'),
    ('Supino declinado', 'Peitoral', 'primary'),
    ('Supino declinado', 'Deltoide', 'secondary'),
    ('Supino declinado', 'Tríceps', 'secondary'),
    ('Mergulho em paralela', 'Peitoral', 'primary'),
    ('Mergulho em paralela', 'Tríceps', 'primary'),
    ('Mergulho em paralela', 'Deltoide', 'secondary'),
    ('Crossover', 'Peitoral', 'primary'),
    ('Crossover', 'Deltoide', 'secondary'),
    ('Crossover inclinado', 'Peitoral', 'primary'),
    ('Crossover inclinado', 'Deltoide', 'secondary'),
    ('Crossover declinado', 'Peitoral', 'primary'),
    ('Crossover declinado', 'Deltoide', 'secondary'),
    ('Crucifixo', 'Peitoral', 'primary'),
    ('Crucifixo', 'Deltoide', 'secondary'),
    ('Crucifixo inclinado', 'Peitoral', 'primary'),
    ('Crucifixo inclinado', 'Deltoide', 'secondary'),
    ('Crucifixo declinado', 'Peitoral', 'primary'),
    ('Crucifixo declinado', 'Deltoide', 'secondary'),

    -- Costas
    ('Barra fixa', 'Dorsais', 'primary'),
    ('Barra fixa', 'Bíceps', 'secondary'),
    ('Barra fixa', 'Deltoide', 'secondary'),
    ('Pulley frente', 'Dorsais', 'primary'),
    ('Pulley frente', 'Bíceps', 'secondary'),
    ('Pulley frente', 'Deltoide', 'secondary'),
    ('Remada baixa', 'Dorsais', 'primary'),
    ('Remada baixa', 'Romboides', 'primary'),
    ('Remada baixa', 'Bíceps', 'secondary'),
    ('Remada baixa', 'Deltoide', 'secondary'),
    ('Remada curvada', 'Dorsais', 'primary'),
    ('Remada curvada', 'Romboides', 'primary'),
    ('Remada curvada', 'Lombar', 'secondary'),
    ('Remada curvada', 'Bíceps', 'secondary'),
    ('Remada serrote', 'Dorsais', 'primary'),
    ('Remada serrote', 'Romboides', 'primary'),
    ('Remada serrote', 'Bíceps', 'secondary'),
    ('Remada serrote', 'Deltoide', 'secondary'),
    ('Remada articulada', 'Dorsais', 'primary'),
    ('Remada articulada', 'Romboides', 'primary'),
    ('Remada articulada', 'Bíceps', 'secondary'),
    ('Remada cavalinho', 'Dorsais', 'primary'),
    ('Remada cavalinho', 'Bíceps', 'secondary'),
    ('Remada cavalinho', 'Deltoide', 'secondary'),
    ('Face pull', 'Deltoide', 'primary'),
    ('Face pull', 'Trapézio', 'secondary'),
    ('Crucifixo invertido', 'Deltoide', 'primary'),
    ('Crucifixo invertido', 'Trapézio', 'secondary'),
    ('Pulldown', 'Dorsais', 'primary'),

    -- Ombro
    ('Desenvolvimento militar', 'Deltoide', 'primary'),
    ('Desenvolvimento militar', 'Tríceps', 'secondary'),
    ('Desenvolvimento com halteres', 'Deltoide', 'primary'),
    ('Desenvolvimento com halteres', 'Tríceps', 'secondary'),
    ('Desenvolvimento Arnold', 'Deltoide', 'primary'),
    ('Desenvolvimento Arnold', 'Tríceps', 'secondary'),
    ('Elevação lateral', 'Deltoide', 'primary'),
    ('Remada alta', 'Deltoide', 'primary'),
    ('Remada alta', 'Trapézio', 'secondary'),
    ('Elevação frontal', 'Deltoide', 'primary'),
    ('Encolhimento', 'Trapézio', 'primary'),

    -- Bíceps
    ('Rosca direta', 'Bíceps', 'primary'),
    ('Rosca alternada', 'Bíceps', 'primary'),
    ('Rosca martelo', 'Bíceps', 'primary'),
    ('Rosca martelo', 'Antebraço', 'secondary'),
    ('Rosca Scott', 'Bíceps', 'primary'),
    ('Rosca concentrada', 'Bíceps', 'primary'),
    ('Rosca polia alta', 'Bíceps', 'primary'),
    ('Rosca Bayesiana', 'Bíceps', 'primary'),
    ('Rosca inclinada', 'Bíceps', 'primary'),
    ('Rosca spider', 'Bíceps', 'primary'),

    -- Tríceps
    ('Tríceps testa', 'Tríceps', 'primary'),
    ('Tríceps francês', 'Tríceps', 'primary'),
    ('Tríceps pulley', 'Tríceps', 'primary'),
    ('Tríceps coice', 'Tríceps', 'primary'),
    ('Supino fechado', 'Tríceps', 'primary'),
    ('Supino fechado', 'Peitoral', 'secondary'),
    ('Supino fechado', 'Deltoide', 'secondary'),

    -- Quadríceps
    ('Agachamento', 'Quadríceps', 'primary'),
    ('Agachamento', 'Glúteo', 'secondary'),
    ('Agachamento', 'Isquiotibiais', 'secondary'),
    ('Agachamento', 'Abdômen', 'secondary'),
    ('Agachamento', 'Lombar', 'secondary'),
    ('Agachamento hack', 'Quadríceps', 'primary'),
    ('Agachamento hack', 'Glúteo', 'secondary'),
    ('Agachamento pêndulo', 'Quadríceps', 'primary'),
    ('Agachamento pêndulo', 'Glúteo', 'secondary'),
    ('Leg press 45', 'Quadríceps', 'primary'),
    ('Leg press 45', 'Glúteo', 'secondary'),
    ('Leg press 45', 'Isquiotibiais', 'secondary'),
    ('Leg press 90', 'Quadríceps', 'primary'),
    ('Leg press 90', 'Glúteo', 'secondary'),
    ('Leg press 180', 'Quadríceps', 'primary'),
    ('Leg press 180', 'Glúteo', 'secondary'),
    ('Cadeira extensora', 'Quadríceps', 'primary'),
    ('Afundo', 'Quadríceps', 'primary'),
    ('Afundo', 'Glúteo', 'secondary'),
    ('Agachamento búlgaro', 'Quadríceps', 'primary'),
    ('Agachamento búlgaro', 'Glúteo', 'primary'),
    ('Agachamento búlgaro', 'Abdômen', 'secondary'),

    -- Posterior / Isquios
    ('Levantamento terra', 'Isquiotibiais', 'primary'),
    ('Levantamento terra', 'Glúteo', 'primary'),
    ('Levantamento terra', 'Lombar', 'primary'),
    ('Levantamento terra', 'Dorsais', 'secondary'),
    ('Levantamento terra', 'Trapézio', 'secondary'),
    ('Levantamento terra romeno', 'Isquiotibiais', 'primary'),
    ('Levantamento terra romeno', 'Glúteo', 'primary'),
    ('Levantamento terra romeno', 'Lombar', 'secondary'),
    ('Levantamento terra stiff', 'Isquiotibiais', 'primary'),
    ('Levantamento terra stiff', 'Glúteo', 'secondary'),
    ('Levantamento terra stiff', 'Lombar', 'secondary'),
    ('Agachamento sumô', 'Glúteo', 'primary'),
    ('Agachamento sumô', 'Quadríceps', 'primary'),
    ('Agachamento sumô', 'Adutores', 'secondary'),
    ('Cadeira flexora', 'Isquiotibiais', 'primary'),
    ('Cama flexora', 'Isquiotibiais', 'primary'),
    ('Cama flexora em pé', 'Isquiotibiais', 'primary'),
    ('Good morning', 'Isquiotibiais', 'primary'),
    ('Good morning', 'Lombar', 'primary'),

    -- Glúteos / Adutores / Abdutores
    ('Elevação pélvica', 'Glúteo', 'primary'),
    ('Elevação pélvica', 'Isquiotibiais', 'secondary'),
    ('Cadeira abdutora', 'Glúteo', 'primary'),
    ('Cadeira adutora', 'Adutores', 'primary'),

    -- Panturrilha
    ('Panturrilha em pé', 'Panturrilha', 'primary'),
    ('Panturrilha sentado', 'Panturrilha', 'primary'),

    -- Core / Abdômen / Lombar
    ('Abdominal declinado', 'Abdômen', 'primary'),
    ('Abdominal na corda', 'Abdômen', 'primary'),
    ('Abdominal suspenso', 'Abdômen', 'primary'),
    ('Abdominal suspenso', 'Flexores de quadril', 'secondary'),
    ('Abdominal dragonflag', 'Abdômen', 'primary'),
    ('Prancha', 'Abdômen', 'primary'),
    ('Hiperextensão lombar', 'Lombar', 'primary')
) AS v(ex_name, musc_name, role_)

JOIN exercise e ON e."name" = v.ex_name
JOIN muscle m ON m."name" = v.musc_name;
-- -----------------------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------------------------
-- Insert de TREINOS
-- Meus 4 treinos: Upper A/B, Lower A/B

INSERT INTO workout ("name", usrEmail) VALUES
    ('Upper A', 'lucascaczmareki@gmail.com'),
    ('Upper B', 'lucascaczmareki@gmail.com'),
    ('Lower A', 'lucascaczmareki@gmail.com'),
    ('Lower B', 'lucascaczmareki@gmail.com'),

    ('Push 1', 'lucascaczmareki@gmail.com'),
    ('Pull 1', 'lucascaczmareki@gmail.com'),
    ('Legs 1', 'lucascaczmareki@gmail.com'),
    ('Full Body 1', 'lucascaczmareki@gmail.com');

-- -----------------------------------------------------------------------------------------------

-- insert de ROUTINE
INSERT INTO routine ("name", usrEmail) VALUES
    ('Tecnica - 2026/1',        'lucascaczmareki@gmail.com'),
    ('Acumulacao - 2026/1',     'lucascaczmareki@gmail.com'),
    ('Intensificacao - 2026/2', 'lucascaczmareki@gmail.com'),
    ('Tecnica - 2026/2',        'lucascaczmareki@gmail.com');

-- -----------------------------------------------------------------------------------------------

-- insert de routine_workout
-- combinação de treinos e rotinas. 
-- ex: acumulacao 2026/1 tem os 2 uppers e os 2 lowers
-- já intensificacao 2026/2 tem push pull e legs

INSERT INTO routine_workout (idRoutine, idWorkout, f_active) VALUES
    ((SELECT id FROM routine WHERE name = 'Tecnica - 2026/1'), (SELECT id FROM workout WHERE name = 'Upper A'), TRUE),
    ((SELECT id FROM routine WHERE name = 'Tecnica - 2026/1'), (SELECT id FROM workout WHERE name = 'Upper B'), TRUE),
    ((SELECT id FROM routine WHERE name = 'Tecnica - 2026/1'), (SELECT id FROM workout WHERE name = 'Lower A'), TRUE),
    ((SELECT id FROM routine WHERE name = 'Tecnica - 2026/1'), (SELECT id FROM workout WHERE name = 'Lower B'), TRUE),

    ((SELECT id FROM routine WHERE name = 'Acumulacao - 2026/1'), (SELECT id FROM workout WHERE name = 'Upper A'), TRUE),
    ((SELECT id FROM routine WHERE name = 'Acumulacao - 2026/1'), (SELECT id FROM workout WHERE name = 'Upper B'), TRUE),
    ((SELECT id FROM routine WHERE name = 'Acumulacao - 2026/1'), (SELECT id FROM workout WHERE name = 'Lower A'), TRUE),
    ((SELECT id FROM routine WHERE name = 'Acumulacao - 2026/1'), (SELECT id FROM workout WHERE name = 'Lower B'), TRUE),

    ((SELECT id FROM routine WHERE name = 'Intensificacao - 2026/2'), (SELECT id FROM workout WHERE name = 'Push 1'), TRUE),
    ((SELECT id FROM routine WHERE name = 'Intensificacao - 2026/2'), (SELECT id FROM workout WHERE name = 'Pull 1'), TRUE),
    ((SELECT id FROM routine WHERE name = 'Intensificacao - 2026/2'), (SELECT id FROM workout WHERE name = 'Legs 1'), TRUE),
    ((SELECT id FROM routine WHERE name = 'Intensificacao - 2026/2'), (SELECT id FROM workout WHERE name = 'Full Body 1'), FALSE),

    ((SELECT id FROM routine WHERE name = 'Tecnica - 2026/2'), (SELECT id FROM workout WHERE name = 'Push 1'), TRUE),
    ((SELECT id FROM routine WHERE name = 'Tecnica - 2026/2'), (SELECT id FROM workout WHERE name = 'Pull 1'), TRUE),
    ((SELECT id FROM routine WHERE name = 'Tecnica - 2026/2'), (SELECT id FROM workout WHERE name = 'Legs 1'), TRUE),
    ((SELECT id FROM routine WHERE name = 'Tecnica - 2026/2'), (SELECT id FROM workout WHERE name = 'Full Body 1'), FALSE);

-- -----------------------------------------------------------------------------------------------

-- insert no plan pra 1 upper A e um lower B

INSERT INTO plan(idWorkout, idExercise, "sets", min_reps, max_reps, min_rir, max_rir) VALUES --esse insert vai usar t_isometric e t_rest padrões
    -- dois exercicios num upper A
    ((SELECT id FROM workout WHERE name = 'Upper A'),
     (SELECT id FROM exercise WHERE name = 'Supino reto' AND idEquipment = (SELECT id FROM equipment WHERE name = 'Olympic barbell') AND f_oneside = FALSE),
     4, 6, 8, 0, 1),

    ((SELECT id FROM workout WHERE name = 'Upper A'),
     (SELECT id FROM exercise WHERE name = 'Tríceps pulley' AND idEquipment = (SELECT id FROM equipment WHERE name = 'Pulley') AND f_oneside = FALSE),
     3, 6, 8, 0, 2),

    -- dois exercicios num lower B
    ((SELECT id FROM workout WHERE name = 'Lower B'),
     (SELECT id FROM exercise WHERE name = 'Agachamento' AND idEquipment = (SELECT id FROM equipment WHERE name = 'Olympic barbell') AND f_oneside = FALSE),
     4, 6, 8, 0, 1),

    ((SELECT id FROM workout WHERE name = 'Lower B'),
     (SELECT id FROM exercise WHERE name = 'Cadeira extensora' AND idEquipment = (SELECT id FROM equipment WHERE name = 'Machine') AND f_oneside = TRUE),
     3, 10, 12, 0, 2);

-- -----------------------------------------------------------------------------------------------

-- insert na session, 1 treino de cada

INSERT INTO session("date", idWorkout) VALUES 
    -- uma ida upper a
    ('2026-01-01', (SELECT id FROM workout WHERE name = 'Upper A')),

    -- uma ida lower b
    ('2026-01-03', (SELECT id FROM workout WHERE name = 'Lower B'));

-- -----------------------------------------------------------------------------------------------

-- insert de execução dos 4 exercícios

INSERT INTO execution(idSession, idPlan) VALUES
    ((SELECT id FROM session WHERE date = '2026-01-01'),
     (SELECT id FROM plan WHERE idWorkout = (SELECT id FROM workout WHERE name = 'Upper A')
        AND idExercise = (SELECT id FROM exercise WHERE name = 'Supino reto' AND idEquipment = (SELECT id FROM equipment WHERE name = 'Olympic barbell') AND f_oneside = FALSE))),

    ((SELECT id FROM session WHERE date = '2026-01-01'),
     (SELECT id FROM plan WHERE idWorkout = (SELECT id FROM workout WHERE name = 'Upper A')
        AND idExercise = (SELECT id FROM exercise WHERE name = 'Tríceps pulley' AND idEquipment = (SELECT id FROM equipment WHERE name = 'Pulley') AND f_oneside = FALSE))),

    ((SELECT id FROM session WHERE date = '2026-01-03'),
     (SELECT id FROM plan WHERE idWorkout = (SELECT id FROM workout WHERE name = 'Lower B')
        AND idExercise = (SELECT id FROM exercise WHERE name = 'Agachamento' AND idEquipment = (SELECT id FROM equipment WHERE name = 'Olympic barbell') AND f_oneside = FALSE))),

    ((SELECT id FROM session WHERE date = '2026-01-03'),
     (SELECT id FROM plan WHERE idWorkout = (SELECT id FROM workout WHERE name = 'Lower B')
        AND idExercise = (SELECT id FROM exercise WHERE name = 'Cadeira extensora' AND idEquipment = (SELECT id FROM equipment WHERE name = 'Machine') AND f_oneside = TRUE)));

-- -----------------------------------------------------------------------------------------------

-- insert das séries dos 4 exercícios realizados

INSERT INTO training_set("weight", reps, rir, idSession, idPlan) VALUES
    --supino
    (27.5, 7, 2,
     (SELECT id FROM session WHERE date = '2026-01-01'),
     (SELECT id FROM plan WHERE idWorkout = (SELECT id FROM workout WHERE name = 'Upper A')
        AND idExercise = (SELECT id FROM exercise WHERE name = 'Supino reto' AND idEquipment = (SELECT id FROM equipment WHERE name = 'Olympic barbell') AND f_oneside = FALSE))),

    (27.5, 7, 1,
     (SELECT id FROM session WHERE date = '2026-01-01'),
     (SELECT id FROM plan WHERE idWorkout = (SELECT id FROM workout WHERE name = 'Upper A')
        AND idExercise = (SELECT id FROM exercise WHERE name = 'Supino reto' AND idEquipment = (SELECT id FROM equipment WHERE name = 'Olympic barbell') AND f_oneside = FALSE))),

    (30, 4, 0,
     (SELECT id FROM session WHERE date = '2026-01-01'),
     (SELECT id FROM plan WHERE idWorkout = (SELECT id FROM workout WHERE name = 'Upper A')
        AND idExercise = (SELECT id FROM exercise WHERE name = 'Supino reto' AND idEquipment = (SELECT id FROM equipment WHERE name = 'Olympic barbell') AND f_oneside = FALSE))),

    (25, 7, 0,
     (SELECT id FROM session WHERE date = '2026-01-01'),
     (SELECT id FROM plan WHERE idWorkout = (SELECT id FROM workout WHERE name = 'Upper A')
        AND idExercise = (SELECT id FROM exercise WHERE name = 'Supino reto' AND idEquipment = (SELECT id FROM equipment WHERE name = 'Olympic barbell') AND f_oneside = FALSE))),

    --triceps
    (65, 10, 2,
     (SELECT id FROM session WHERE date = '2026-01-01'),
     (SELECT id FROM plan WHERE idWorkout = (SELECT id FROM workout WHERE name = 'Upper A')
        AND idExercise = (SELECT id FROM exercise WHERE name = 'Tríceps pulley' AND idEquipment = (SELECT id FROM equipment WHERE name = 'Pulley') AND f_oneside = FALSE))),

    (70, 7, 1,
     (SELECT id FROM session WHERE date = '2026-01-01'),
     (SELECT id FROM plan WHERE idWorkout = (SELECT id FROM workout WHERE name = 'Upper A')
        AND idExercise = (SELECT id FROM exercise WHERE name = 'Tríceps pulley' AND idEquipment = (SELECT id FROM equipment WHERE name = 'Pulley') AND f_oneside = FALSE))),

    (70, 7, 0,
     (SELECT id FROM session WHERE date = '2026-01-01'),
     (SELECT id FROM plan WHERE idWorkout = (SELECT id FROM workout WHERE name = 'Upper A')
        AND idExercise = (SELECT id FROM exercise WHERE name = 'Tríceps pulley' AND idEquipment = (SELECT id FROM equipment WHERE name = 'Pulley') AND f_oneside = FALSE))),

    -- agachamento
    (40, 6, 2,
     (SELECT id FROM session WHERE date = '2026-01-03'),
     (SELECT id FROM plan WHERE idWorkout = (SELECT id FROM workout WHERE name = 'Lower B')
        AND idExercise = (SELECT id FROM exercise WHERE name = 'Agachamento' AND idEquipment = (SELECT id FROM equipment WHERE name = 'Olympic barbell') AND f_oneside = FALSE))),

    (40, 6, 1,
     (SELECT id FROM session WHERE date = '2026-01-03'),
     (SELECT id FROM plan WHERE idWorkout = (SELECT id FROM workout WHERE name = 'Lower B')
        AND idExercise = (SELECT id FROM exercise WHERE name = 'Agachamento' AND idEquipment = (SELECT id FROM equipment WHERE name = 'Olympic barbell') AND f_oneside = FALSE))),

    (40, 6, 0,
     (SELECT id FROM session WHERE date = '2026-01-03'),
     (SELECT id FROM plan WHERE idWorkout = (SELECT id FROM workout WHERE name = 'Lower B')
        AND idExercise = (SELECT id FROM exercise WHERE name = 'Agachamento' AND idEquipment = (SELECT id FROM equipment WHERE name = 'Olympic barbell') AND f_oneside = FALSE))),

    (40, 5, 0,
     (SELECT id FROM session WHERE date = '2026-01-03'),
     (SELECT id FROM plan WHERE idWorkout = (SELECT id FROM workout WHERE name = 'Lower B')
        AND idExercise = (SELECT id FROM exercise WHERE name = 'Agachamento' AND idEquipment = (SELECT id FROM equipment WHERE name = 'Olympic barbell') AND f_oneside = FALSE))),

    -- cadeira extensora
    (100, 13, 2,
     (SELECT id FROM session WHERE date = '2026-01-03'),
     (SELECT id FROM plan WHERE idWorkout = (SELECT id FROM workout WHERE name = 'Lower B')
        AND idExercise = (SELECT id FROM exercise WHERE name = 'Cadeira extensora' AND idEquipment = (SELECT id FROM equipment WHERE name = 'Machine') AND f_oneside = TRUE))),

    (100, 13, 1,
     (SELECT id FROM session WHERE date = '2026-01-03'),
     (SELECT id FROM plan WHERE idWorkout = (SELECT id FROM workout WHERE name = 'Lower B')
        AND idExercise = (SELECT id FROM exercise WHERE name = 'Cadeira extensora' AND idEquipment = (SELECT id FROM equipment WHERE name = 'Machine') AND f_oneside = TRUE))),

    (100, 13, 0,
     (SELECT id FROM session WHERE date = '2026-01-03'),
     (SELECT id FROM plan WHERE idWorkout = (SELECT id FROM workout WHERE name = 'Lower B')
        AND idExercise = (SELECT id FROM exercise WHERE name = 'Cadeira extensora' AND idEquipment = (SELECT id FROM equipment WHERE name = 'Machine') AND f_oneside = TRUE)));