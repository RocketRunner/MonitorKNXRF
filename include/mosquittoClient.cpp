#include "mosquittoClient.h"
#include <mosquittopp.h>
#include <cstring>

#include <iostream> //std::cout
#include <ostream> //std::endl

mosquittoClient::mosquittoClient(const char *_id, const char *_host, int _port) : mosquittopp(_id) {
    mosqpp::lib_init();
    this->keepalive = DEFAULT_KEEP_ALIVE;
    this->id = _id;
    this->port = _port;
    this->host = _host;
    username_pw_set(MQTT_USER, MQTT_PASSWORD);
    connect_async(host, port, keepalive);
    loop_start();
}

mosquittoClient::~mosquittoClient() {
    loop_stop();
    mosqpp::lib_cleanup();
}

bool mosquittoClient::send_message(const char *_topic, const char *_message) {
    int ret = publish(NULL, _topic, strlen(_message), _message, 1, false);
    return (ret == MOSQ_ERR_SUCCESS);
}

void mosquittoClient::on_disconnect(int rc) {
    std::cout << ">> MosquittoClient - disconnection(" << rc << ")" << std::endl;
}

void mosquittoClient::on_connect(int rc) {
    if (rc == 0) {
        std::cout << ">> MosquittoClient - connected with server" << std::endl;
    } else {
        std::cout << ">> MosquittoClient - Impossible to connect with server(" << rc << ")" << std::endl;
    }
}

void mosquittoClient::on_publish(int mid) {
    std::cout << ">> MosquittoClient - Message (" << mid << ") succeed to be published " << std::endl;
}

void mosquittoClient::on_message(const struct mosquitto_message *message) {
    //char *pchar = (char *) (message->payload);
    //string str(pchar);

    //DO SOMETHING WITH THE MESSAGE...
}

void mosquittoClient::on_subscribe(int mid, int qos_count, const int *granted_qos) {
    std::cout << ">> subscription succeeded (" << mid << ") " << std::endl;
}

void mosquittoClient::on_unsubscribe(int mid) {
    std::cout << "unscubscribed";
}