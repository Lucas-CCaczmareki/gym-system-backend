BEGIN;
-- Sistema de autenticação
    
    -- Criar conta:
\bind 'teste@gmail.com' 'Teste da Silva' 'teste123'
INSERT INTO usr(email, "name", senha, f_active) VALUES
    ($1, $2, crypt($3, gen_salt('bf')), TRUE)
ON CONFLICT (email) DO NOTHING
RETURNING email, "name";

    -- Atualizar email
\bind 'testeDaSilva@gmail.com' 'teste@gmail.com'
UPDATE usr 
SET email = $1
WHERE email = $2 AND NOT EXISTS 
    (SELECT * FROM usr WHERE email = $1); --confere se o email novo já não tá cadastrado

    -- Atualiza o nome
\bind 'testeDaSilva@gmail.com' 'Fulando de Tal'
UPDATE usr
SET "name" = $2
WHERE email = $1;

    -- Atualiza a senha
\bind 'testeDaSilva@gmail.com' '123teste'
UPDATE usr
SET senha = crypt($2, gen_salt('bf'))
WHERE email = $1;

    -- Apagar conta (soft-delete):
\bind 'testeDaSilva@gmail.com'
UPDATE usr
SET f_active = FALSE
WHERE email = $1;

    -- Apagar conta (hard-delete):
\bind 'testeDaSilva@gmail.com'
DELETE FROM usr WHERE email = $1;

    -- Busca o usuário pelo email (login)
\bind 'lucascaczmareki@gmail.com' 'lucas123'
SELECT email, "name" FROM usr
WHERE email = $1 AND senha = crypt($2, senha) AND f_active = TRUE;

ROLLBACK; --o rollback desfaz todas operações do BEGIN até o ROLLBACK