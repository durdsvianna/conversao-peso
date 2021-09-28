FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src

#copia solution e projeto 
COPY *.sln .
COPY ConversaoPeso.Web/*.csproj ./ConversaoPeso.Web/
RUN dotnet restore

#copia o resto
COPY ConversaoPeso.Web/. ./ConversaoPeso.Web/
WORKDIR /src/ConversaoPeso.Web
RUN dotnet publish -c release -o /app --no-restore

#imagem final
FROM mcr.microsoft.com/dotnet/aspnet:5.0
WORKDIR /app
COPY --from=build /app ./
CMD ["dotnet", "ConversaoPeso.Web.dll"]