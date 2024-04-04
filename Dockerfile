# Utilizamos una imagen base de Ruby
FROM ruby:2.7

# Instalamos las dependencias necesarias para Jekyll
RUN apt-get update -qq && apt-get install -y nodejs

# Directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiamos el Gemfile y Gemfile.lock
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

# Instalamos las gemas, incluyendo Jekyll
RUN bundle install

# Copiamos el resto del proyecto al directorio de trabajo
COPY . /app

# Exponemos el puerto 4000, que es el puerto por defecto de Jekyll
EXPOSE 4000

# Comando para iniciar Jekyll
CMD ["jekyll", "serve", "--host", "0.0.0.0"]
