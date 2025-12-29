package gym_backend.dto;

public class EchoResponse {
    private String echo;

    public EchoResponse(String echo) {
        this.echo = echo;
    }

    public String getEcho() {
        return echo;
    }

}
