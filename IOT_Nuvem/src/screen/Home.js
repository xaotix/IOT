import React, { useState, useEffect } from 'react';
import { StyleSheet, Text, View, FlatList, TouchableOpacity, Alert} from 'react-native';
import * as conexoes from '../service/conexoes'
import * as vars from '../service/propriedades'
import { Tab, Tabs, TabHeading, } from 'native-base';
import { List } from 'react-native-paper';
import { FontAwesome } from '@expo/vector-icons';
import { Cell, Section } from 'react-native-tableview-simple';



const Home = (props) => {
  const { navigation } = props
  const [tf_icon, set_tf_icon] = useState("medkit")
  const [tfi_icon, set_tfi_icon] = useState("clock-o")
  const [tff_icon, set_tff_icon] = useState("warning")
  const [todastarefas, setTodasTarefas] = useState([])
  const [acessos, setAcessos] = useState([])
  const [acessos_febre, setAcessos_febre] = useState([])
  const [registros, set_registros] = useState([])
  const [tarefasiniciadas, setTarefasiniciadas] = useState([])
  const [tarefasfinalizadas, setTarefafinalizadas] = useState([])
  const [item_selecionado, set_item_selecionado] = useState()
  const [loading, setLoading] = useState(false)
  const [expanded, setExpanded] = React.useState(false);

  useEffect(
    () => {
      getDados()
    }, []
  )

  const getDados = () => {
    setLoading(true)

    conexoes.get_acessos()
      .then(retorno => {
        console.log("Retornou!")

        if (retorno.Status === "OK") {
          console.log("Status passou!")
          setTodasTarefas(retorno.Valores)
          setAcessos(retorno.Valores);
          console.log("Mapeou Acessos!");
        }
        else {
          alert(retorno.Status)

          console.log(retorno.Status);
        }
      })
      .catch(erro => {
        alert(erro)
        console.log(erro);
      }
      )


    conexoes.get_acessos_febre()
      .then(retorno => {
        console.log("Retornou!")

        if (retorno.Status === "OK") {
          console.log("Status passou!")

          setAcessos_febre(retorno.Valores);
          console.log("Mapeou Acessos com febre!");
        }
        else {
          alert(retorno.Status)

          console.log(retorno.Status);
        }
      })
      .catch(erro => {
        alert(erro)
        console.log(erro);
      }
      )


      conexoes.get_registros()
      .then(retorno => {
        console.log("Retornou!")

        if (retorno.Status === "OK") {
          console.log("Status passou!")

          set_registros(retorno.Valores);
          console.log("Mapeou Acessos com febre!");
        }
        else {
          alert(retorno.Status)

          console.log(retorno.Status);
        }
      })
      .catch(erro => {
        alert(erro)
        console.log(erro);
      }
      )

    setLoading(false);

  }


  useEffect(() => {
    getDados()

  }, [])




  const handlePress = () => setExpanded(!expanded);
  return (
    <View flex={1}>
      <Tabs initialPage={0} >
        <Tab heading={<TabHeading style={styles.tabHeader}><FontAwesome name="home" size={24} color="white" /></TabHeading>}>
          <View style={styles.header}>
            <View margin={10}>
              <Text>Bem vindo {vars.usuario.nome}</Text>
              <Text><FontAwesome name="envelope-o" size={16} color={vars.cor1} /> {vars.usuario.email}</Text>
              <Text><FontAwesome name="user" size={16} color={vars.cor1} /> {vars.usuario.user}</Text>

            </View>
          </View>
          <View marginBottom={10}>
            <View style={styles.caixaBotao}>
              <FontAwesome.Button style={styles.botao} name="info-circle" onPress={
                () => {
                  navigation.replace('Sobre')
                }
              }>Sobre</FontAwesome.Button>
            </View>

            <View style={styles.caixaBotao}>
              <FontAwesome.Button style={styles.botao} name="power-off" onPress={
                () => {
                  navigation.replace('Login')
                }
              }>Logout</FontAwesome.Button>
            </View>
          </View>
        </Tab>
        <Tab heading={<TabHeading style={styles.tabHeader}><Text style={styles.texto}> Registros </Text></TabHeading>}>
          <FlatList
            data={registros}
            renderItem={({ item }) =>
              <TouchableOpacity
                onPress={() => {
                  set_item_selecionado(item);
                }}
              >
                <View style={styles.card}>
                  <List.Accordion title={<Text>{item.dia} / {item.mes} / {item.ano} - {item.hora}</Text>

                  }
                    left={props => <FontAwesome name={tf_icon} size={32} color={vars.cor1} />}

                    onPress={handlePress}>


                    <Section>
                    <Cell cellStyle="RightDetail" title={<Text><FontAwesome name="medkit" size={16} style={styles.iconesinternos} /> Temperatura:</Text>} detail={item.temperatura} />

                    </Section>

                  </List.Accordion>
                </View>

              </TouchableOpacity>
            }
          />

        </Tab>
        <Tab heading={<TabHeading style={styles.tabHeader}><Text style={styles.texto}> Status </Text></TabHeading>}>
          <FlatList
            data={acessos}
            renderItem={({ item }) =>
              <TouchableOpacity
                onPress={() => {
                  set_item_selecionado(item);
                }}
              >
                <View style={styles.card}>
                  <List.Accordion title={<Text>{item.dia} / {item.mes} / {item.ano}</Text>

                  }
                    left={props => <FontAwesome name="shopping-bag" size={32} color={vars.cor1} />}

                    onPress={handlePress}>


                    <Section>
                      <Cell cellStyle="RightDetail" title={<Text><FontAwesome name="smile-o" size={16} style={styles.iconesinternos} /> Clientes:</Text>} detail={item.pessoas} />
                      <Cell cellStyle="RightDetail" title={<Text><FontAwesome name="fire" size={16} style={styles.iconesinternos} /> Maior temperatura:</Text>} detail={item.max} />
                      <Cell cellStyle="RightDetail" title={<Text><FontAwesome name="snowflake-o" size={16} style={styles.iconesinternos} /> Menor temperatura:</Text>} detail={<Text> {item.min}</Text>} />
                      <Text></Text>
                    </Section>

                  </List.Accordion>
                </View>

              </TouchableOpacity>
            }
          />

        </Tab>
        <Tab heading={<TabHeading style={styles.tabHeader}><Text style={styles.texto}> Alertas  </Text></TabHeading>}>
          <FlatList
            data={acessos_febre}
            renderItem={({ item }) =>
              <TouchableOpacity
                onPress={() => {
                  set_item_selecionado(item);
                }}
              >
                <View style={styles.card}>
                  <List.Accordion title={<Text>{item.dia} / {item.mes} / {item.ano}</Text>

                  }
                    left={props => <FontAwesome name={tff_icon} size={32} color={vars.cor1} />}

                    onPress={handlePress}>

                    <Section>
                      <Cell cellStyle="RightDetail" title={<Text><FontAwesome name="exclamation-circle" size={16} style={styles.iconesinternos} /> Pessoas com febre:</Text>} detail={item.pessoas} />
                      <Cell cellStyle="RightDetail" title={<Text><FontAwesome name="fire" size={16} style={styles.iconesinternos} /> Maior febre:</Text>} detail={item.max} />
                      <Cell cellStyle="RightDetail" title={<Text><FontAwesome name="snowflake-o" size={16} style={styles.iconesinternos} /> Menor febre:</Text>} detail={<Text> {item.min}</Text>} />
                      <Text></Text>
                    </Section>

                  </List.Accordion>
                </View>

              </TouchableOpacity>
            }
          />

        </Tab>
      </Tabs>



    </View>
  );
}
export default Home

const styles = StyleSheet.create({
  tabHeader: {
    backgroundColor: '#685aa4',
  },
  botao: {
    backgroundColor: vars.cor1,
  },
  texto:
  {
    color: 'white'
  },
  iconesinternos:
  {
    color: "black"
  },

  header: {

    margin: 10,
    borderWidth: 2,
    borderColor: vars.cor1,
    backgroundColor: 'white',
  },
  card: {
    marginTop: 5,
    marginLeft: 10,
    marginRight: 10,
    borderWidth: 2,
    borderTopLeftRadius: 25,
    borderBottomRightRadius: 25,
    borderColor: vars.cor1,
    backgroundColor: 'white'

  },
  container: {

    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: '#ffffff',
  },
  caixaTexto: {
    width: "90%",
    borderWidth: 1,

    padding: 5,
    marginTop: 5
  }, caixaBotao: {
    paddingRight: 10,
    paddingLeft: 10,
    marginTop: 10,
    justifyContent: 'center',
  },
  caixaBotao2: {
    marginTop: 5,
    marginBottom: 5,

  },
});