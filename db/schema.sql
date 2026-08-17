DROP SCHEMA IF EXISTS gymsystem CASCADE;
CREATE SCHEMA gymsystem;
SET search_path TO gymsystem;

-- enums (types)
CREATE TYPE measure_unit AS ENUM ('kg', 'lb');

--adicionar mais aqui no futuro
CREATE TYPE technique AS ENUM ('normal', 'drop_set', 'rest_pause', 'cluster_set'); 

-- CREATE TYPE equipment AS ENUM ('barbell', 'smith', 'pulley', 'machine', 'dumbbell', 'bodyweight');

CREATE TYPE exercise_type AS ENUM ('isolated', 'compound');

CREATE TYPE muscle_role AS ENUM ('primary', 'secondary');

-- tables
CREATE TABLE usr (
    email VARCHAR(255) PRIMARY KEY NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    senha VARCHAR(255) NOT NULL,
    f_active BOOLEAN NOT NULL
);

CREATE TABLE routine(
    id SERIAL PRIMARY KEY,
    "name" VARCHAR(255) NOT NULL,
    usrEmail VARCHAR(255) NOT NULL,

    FOREIGN KEY (usrEmail) REFERENCES usr(email) ON DELETE CASCADE --se o usuário for deletado, todas rotinas dele vão junto
);

CREATE TABLE workout (
    id SERIAL PRIMARY KEY,
    "name" VARCHAR(255) NOT NULL,
    usrEmail VARCHAR(255) NOT NULL,

    FOREIGN KEY (usrEmail) REFERENCES usr(email) ON DELETE CASCADE --se o usuário for deletado, todas rotinas dele vão junto
);

CREATE TABLE routine_workout (
    idRoutine INTEGER NOT NULL,
    idWorkout INTEGER NOT NULL,
    f_active BOOLEAN DEFAULT FALSE,

    PRIMARY KEY(idRoutine, idWorkout),

    --treino existe APESAR da rotina. Rotina organiza conjunto de treinos pra 1 ciclo (por exemplo semana)
    FOREIGN KEY (idRoutine) REFERENCES routine(id) ON DELETE CASCADE, 
    FOREIGN KEY (idWorkout) REFERENCES workout(id) ON DELETE CASCADE
);


CREATE TABLE session (
    id SERIAL PRIMARY KEY, --usa id serial como PK pra facilitar referenciação 
    "date" DATE NOT NULL,
    idWorkout INTEGER NOT NULL,

    FOREIGN KEY (idWorkout) REFERENCES workout(id) ON DELETE RESTRICT, --bloqueia pq uma sessao só existe a partir de um workout.
    UNIQUE (date, idWorkout) --mantém unicidade desses elementos
);

CREATE TABLE equipment (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    base_weight FLOAT NOT NULL
);

CREATE TABLE exercise (
    id SERIAL PRIMARY KEY,
    "name" VARCHAR(256) NOT NULL,
    "type" exercise_type NOT NULL,
    f_oneside BOOLEAN DEFAULT FALSE NOT NULL,
        
    idEquipment INTEGER NOT NULL,
    idUsr VARCHAR(256), -- se for NULL, o exercício pertence à uma base comum e aparece pra todos usuários

    FOREIGN KEY (idEquipment) REFERENCES equipment(id) ON DELETE RESTRICT,
    FOREIGN KEY (idUsr) REFERENCES usr(email) ON DELETE CASCADE --deleta todos exercícios criados por aquele usr
    -- UNIQUE(name, idEquipment, f_oneside)
);

-- O comportamento desse id vai permitir os users criarem exercícios personalizados com o mesmo nome
-- ou criar exercícios personalizados de exercicios q ja existem na base (trocando o nome por exemplo)
-- mas vai bloquear o usr de criar o mesmo exercício duas vezes (a mesma coisa vale pra base)

-- cria um índice único pra toda entrada (name, idEquip, oneside) com idUsr null
CREATE UNIQUE INDEX exercise_global_unique
    ON exercise(name, idEquipment, f_oneside)
    WHERE idUsr IS NULL;

-- cria um índice único pra toda entrada (name, idEquip, oneside) com idUsr not null
CREATE UNIQUE INDEX exercise_personal_unique
    ON exercise(name, idEquipment, f_oneside, idUsr)
    WHERE idUsr IS NOT NULL;

CREATE TABLE muscle (
    "name" VARCHAR(256) PRIMARY KEY
);

CREATE TABLE mscl_activation (
    idExercise INTEGER NOT NULL,
    idMuscle VARCHAR(256) NOT NULL,
    "role" muscle_role NOT NULL,

    PRIMARY KEY (idExercise, idMuscle),
    FOREIGN KEY (idExercise) REFERENCES exercise(id) ON DELETE CASCADE,
    FOREIGN KEY (idMuscle) REFERENCES muscle("name") ON DELETE CASCADE
);

CREATE TABLE plan (
    id SERIAL PRIMARY KEY,
    t_isometric FLOAT DEFAULT 0.0,
    "sets" INTEGER NOT NULL,

    min_reps INTEGER NOT NULL,
    max_reps INTEGER NOT NULL,
    min_rir INTEGER CHECK (min_rir >= 0),
    max_rir INTEGER CHECK (max_rir <= 10), 

    CHECK (min_reps <= max_reps),
    CHECK(min_rir <= max_rir),

    t_rest FLOAT,
    idWorkout INTEGER NOT NULL,
    idExercise INTEGER NOT NULL,
    
    FOREIGN KEY (idWorkout) REFERENCES workout(id) ON DELETE CASCADE,
    FOREIGN KEY (idExercise) REFERENCES exercise(id) ON DELETE CASCADE, -- se n tiver execução, apaga, se tiver vai bloquear
    UNIQUE (idWorkout, idExercise)
);

-- representa 1 execução (todas as séries) de um exercício naquele treino
CREATE TABLE execution (
    idSession INTEGER NOT NULL,
    idPlan INTEGER NOT NULL,
    t_rest FLOAT, --ele pode ser null, ou o cara pode contar isso se quiser
    unit measure_unit NOT NULL DEFAULT 'kg',

    PRIMARY KEY (idSession, idPlan),

    -- Se já existir uma execução atrelada, bloqueia o delete
    FOREIGN KEY (idSession) REFERENCES session(id) ON DELETE RESTRICT,
    FOREIGN KEY (idPlan) REFERENCES plan(id) ON DELETE RESTRICT
);


-- Se algum dia eu quiser expandir, aqui talvez seja um bom lugar pra eu colocar o tipo da pegada
-- mas isso aqui não influencia tanto no resultado q eu quero, q é registro de progressão de carga
CREATE TABLE training_set (
    id SERIAL PRIMARY KEY,
    "weight" FLOAT NOT NULL DEFAULT 0.0,
    t_isometric FLOAT DEFAULT 0.0, -- representa tempo em isometria (seja prancha ou pausas) em qualquer exercício
    reps INTEGER NOT NULL,
    rir INTEGER CHECK (rir >= 0), 
    tech technique NOT NULL DEFAULT 'normal',
    tech_level INTEGER CHECK (tech_level BETWEEN 0 AND 10), -- nivel/qualidade da execução (opcional)

    idSession INTEGER NOT NULL,
    idPlan INTEGER NOT NULL,

    FOREIGN KEY (idSession, idPlan) REFERENCES execution(idSession, idPlan) ON DELETE CASCADE
);