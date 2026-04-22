

CREATE OR REPLACE PACKAGE synuser_agents_subtypes AS
   SUBTYPE agents_rowtype IS AGENTS%ROWTYPE;
   SUBTYPE agent_id_subtype IS agents.agent_id%TYPE;
--
END;
.
/

show errors

grant all on synuser_agents_subtypes to public;

exit;


