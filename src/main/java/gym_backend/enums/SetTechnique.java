package gym_backend.enums;

public enum SetTechnique {
    NORMAL,
    DROPSET,    
    REST_PAUSE, // 1 set até a falha técnica. Descansa 20-30s. Repete até a falha de novo.
    MYO_REPS,   // 1 set até 1-2RM, descansa 15-20s, extrai + 4 rep. Repete até não conseguir fazer
    AMRAP,      // 1 set até a falha técnica
    SUPERSET,   // == BISET. Esse set foi feito em conjunto com outro set
    CLUSTERSET  // 1 série/10rep -> 3 séries 4-6 reps 80-95% 1RM
}
