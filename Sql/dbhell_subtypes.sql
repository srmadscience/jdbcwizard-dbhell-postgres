


CREATE OR REPLACE PACKAGE agents_subtypes_types AS
   SUBTYPE agents_rowtype IS AGENTS%ROWTYPE;
   SUBTYPE agent_id_subtype IS agents.agent_id%TYPE;
--
END;
.
/

show errors

CREATE OR REPLACE PACKAGE agents_subtypes AS
--
   SUBTYPE agents_rowtype IS AGENTS%ROWTYPE;
   SUBTYPE agent_id_subtype IS agents.agent_id%TYPE;
   SUBTYPE truly_insane IS agents_subtypes_types.agents_rowtype;
--
   PROCEDURE agt_subtypes_01 (p_syn_ast_ar   in out synuser.synuser_agents_subtypes.agents_rowtype
                             ,p_syn_ast_ais  in out synuser.synuser_agents_subtypes.agent_id_subtype 
                             ,p_ast_ar   in out agents_subtypes_types.agents_rowtype
                             ,p_ast_ais  in out agents_subtypes_types.agent_id_subtype 
                             ,p_ar       in out agents_rowtype
                             ,p_ais      in out agent_id_subtype
                             ,p_normal   in out agents%ROWTYPE
                             ,p_insane   in out truly_insane );
--
END;
.
/

CREATE OR REPLACE PACKAGE BODY agents_subtypes AS
--
   PROCEDURE agt_subtypes_01 (p_syn_ast_ar   in out synuser.synuser_agents_subtypes.agents_rowtype
                             ,p_syn_ast_ais  in out synuser.synuser_agents_subtypes.agent_id_subtype
                             ,p_ast_ar   in out agents_subtypes_types.agents_rowtype
                             ,p_ast_ais  in out agents_subtypes_types.agent_id_subtype
                             ,p_ar       in out agents_rowtype
                             ,p_ais      in out agent_id_subtype
                             ,p_normal   in out agents%ROWTYPE
                             ,p_insane   in out truly_insane ) IS
--
BEGIN
--
  NULL;
--
END;
--
END;
.
/

show errors

exit;


