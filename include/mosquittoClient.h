#ifndef MOSQUITTOCLIENT_H
#define MOSQUITTOCLIENT_H

#include <mosquittopp.h>
#include <mosquitto.h>

#define DEFAULT_KEEP_ALIVE 60
#define MQTT_CLIENT_ID "KNXRF"
#define MQTT_HOST "192.168.1.5"
#define MQTT_PORT 1883
#define MQTT_USER "uponor-mqtt-bridge"
#define MQTT_PASSWORD "uponor-mqtt-bridge"

class mosquittoClient : public mosqpp::mosquittopp {
private:
    const char *host;
    const char *id;
    int port;
    int keepalive;

    void on_connect(int rc);
    void on_disconnect(int rc);
    void on_publish(int mid);
    void on_subscribe(int mid, int qos_count, const int *granted_qos);
    void on_unsubscribe(int mid);
    void on_message(const struct mosquitto_message *message);

public:
    mosquittoClient(const char *id, const char *host, int port);
    ~mosquittoClient();
    bool send_message(const char *_topic, const char *_message);
};

#endif