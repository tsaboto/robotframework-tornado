# Criar uma aplicação web com dois endpoints:
#
# - Utilizar o tornado para criar a aplicação
#
# - POST /content/:file
# 	-- recebe um conteudo via body e salva em um arquivo. O nome deste arquivo é enviado via path param.
# 	-- se o body estiver vazio, retornar o status http 400
# - GET /content/:file
# 	-- lê o arquivo enviado via path param
# 	-- se não houver o arquivo, retornar o status 404
#
# - Criar um projeto robot para fazer os testes dessas api's

import tornado.ioloop
import tornado.web
import tornado


class MainHandler(tornado.web.RequestHandler):
    def get_app(self):
        return make_app()


class CreateFile(tornado.web.RequestHandler):
    def post(self, file_name):
        body = bytes.decode(self.request.body)

        if body == '':
            self.set_status(400)
            self.finish("Aquivo sem conteudo")
            return
        else:
            file = open(file_name+".txt", 'w')
            file.write(body)
            self.finish("Mensagem criada com sucesso")
            file.close()

    def get(self, file_name):
        try:
            file = open(file_name+".txt", 'r')
            self.write(file.read())
            file.close()
        except IOError:
            self.set_status(404)
            self.finish("Arquivo não existente")
            return


def make_app():
    return tornado.web.Application([
        (r"/", MainHandler),
        (r"/content/(\w+)", CreateFile),
        ])


if __name__ == "__main__":
    app = make_app()
    app.listen(8888)
    tornado.ioloop.IOLoop.current().start()