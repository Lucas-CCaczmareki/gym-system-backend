package gym_backend.dto;

import gym_backend.enums.SetTechnique;
import gym_backend.enums.SetType;
import lombok.Data;

@Data // isso usa a biblioteca "lombok" pra criar automaticamente todos getters e setters dos atributos
public class SetDTO {
    
    // Modelando usando wrappers para caso o usuário não digite/esqueça algum

    // Atributos para marcar peso. O calculo vai ser feito internamente depois com base no tipo do exercício
    private Double barbellWeight;   // peso da barra. Vou considerar 0 se n for de barra, provavelmente
    private Double weightPerSide;   // anilhas de um lado ou por exemplo, no cross, o peso de um lado
    private Double totalWeight;     // usa quando for uma máquina, tipo cadeira extensora

    private Integer reps;               // 6, 8, 10...
    private Integer rir;                // 1, 2

    // Set technique -> restpause, dropset, etc
    private SetTechnique technique;     // dropset, superset, clusterset
    private SetType type;               // normal, top, back, warm up, feeder.
    private String note;                // ex: melhorar amplitude. Evitar falha mecânica (multiarticular)

}
