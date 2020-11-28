import axios from 'axios'
import * as vars from './propriedades'




export const autenticar = (user, password) => {
    return new Promise((resolve, reject) => {

      const response =  axios.post(vars.servidor + 'consultar/', 
      {
        user: user,
        s: password,
        Banco: vars.db,
        Tabela: "pme_tipo_recurso",
        Filtros:
        {
          id: "%%"
        }
      })
      .then((response) => {
        /*grava os dados de retorno*/
          const dados = response.data;
          vars.usuario.user = user;
          vars.usuario.s = password;
          vars.usuario.nome = dados.Nome;
          vars.usuario.id_user = dados.id_user;
          vars.usuario.autenticado = dados.Status === "OK";
          vars.usuario.email = dados.Email
          vars.usuario.s = password;
          console.log("Retorno da autenticação")
          resolve(dados);
          console.log("Fim")

      }, (erro) => {
        reject(erro);
      });
  })
  }

  export const gravar_tarefas = (chave) => {
    return new Promise((resolve, reject) => {
      const response =  axios.post(vars.servidor + 'salvar/', chave
     
      )
      .then((response) => {
          const dados = response.data;
        resolve(dados);
      }, (erro) => {
        reject(erro);
      });
  })
  }
  export const atualizar_tarefas = (chave) => {
    return new Promise((resolve, reject) => {
      const response =  axios.post(vars.servidor + 'atualizar/', chave
     
      )
      .then((response) => {
          const dados = response.data;
        resolve(dados);
      }, (erro) => {
        reject(erro);
      });
  })
  }

  export const get_acessos = () => {
    return new Promise((resolve, reject) => {
      const response =  axios.post(vars.servidor + 'consultar/', {
        user: vars.usuario.user,
        s: vars.usuario.s,
        Banco: vars.db,
        Tabela: "iot_log_acessos",
        Filtros:
        {
          porta: 1
        }
      }
     
      )
      .then((response) => {
          const dados = response.data;
        resolve(dados);
      }, (erro) => {
        reject(erro);
      });
  })
  }
  export const get_registros = () => {
    return new Promise((resolve, reject) => {
      const response =  axios.post(vars.servidor + 'consultar/', {
        user: vars.usuario.user,
        s: vars.usuario.s,
        Banco: vars.db,
        Tabela: "iot_log_temperaturas",
        Filtros:
        {
          porta: 1
        }
      }
     
      )
      .then((response) => {
          const dados = response.data;
        resolve(dados);
      }, (erro) => {
        reject(erro);
      });
  })
  }
  export const get_acessos_febre = () => {
    return new Promise((resolve, reject) => {
      const response =  axios.post(vars.servidor + 'consultar/', {
        user: vars.usuario.user,
        s: vars.usuario.s,
        Banco: vars.db_comum,
        Tabela: "iot_log_acessos_febre",
        Filtros:
        {
          porta: 1
        }
      }
     
      )
      .then((response) => {
          const dados = response.data;
        resolve(dados);
      }, (erro) => {
        reject(erro);
      });
  })
  }
  export const apagar_tarefa = (item) => {
    const chave = {
      user: vars.usuario.user,
      s: vars.usuario.s,
      Banco: vars.db,
      Tabela: "pme_tarefas",
      Filtros:
      {
        id_recurso: vars.usuario.id_user,
        id: item.id
      }
    }
    return new Promise((resolve, reject) => {
      const response =  axios.post(vars.servidor + 'apagar/', chave)
      .then((response) => {
          const dados = response.data;
        resolve(dados);
      }, (erro) => {
        reject(erro);
      });
  })
  }